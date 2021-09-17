
import 'dart:async';

import 'package:kin_base/base/models/appidx.dart';
import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_memo.dart';
import 'package:kin_base/base/models/kin_payment_item.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/solana/instruction.dart';
import 'package:kin_base/base/models/solana/programs.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'package:kin_base/base/models/stellar_base_type_conversions.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/network/api/kin_account_api_v4.dart';
import 'package:kin_base/base/network/api/kin_account_creation_api_v4.dart';
import 'package:kin_base/base/network/api/kin_streaming_api_v4.dart';
import 'package:kin_base/base/network/api/kin_transaction_api_v4.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/base/tools/byte_utils.dart';
import 'package:kin_base/base/tools/cache.dart';
import 'package:kin_base/base/tools/extensions.dart';
import 'package:kin_base/base/tools/kin_logger.dart';
import 'package:kin_base/base/tools/network_operations_handler.dart';
import 'package:kin_base/base/tools/observers.dart';
import 'package:kin_base/stellarfork/key_pair.dart';

import 'kin_service.dart';

class KinServiceImplV4 extends KinService {

  final NetworkEnvironment networkEnvironment ;
  final NetworkOperationsHandler networkOperationsHandler ;
  final KinAccountApiV4 accountApi ;
  final KinTransactionApiV4 transactionApi ;
  final KinStreamingApiV4? streamingApi ;
  final KinAccountCreationApiV4 accountCreationApi ;
  final KinLoggerFactory logger;

  KinServiceImplV4(
      this.networkEnvironment,
      this.networkOperationsHandler,
      this.accountApi,
      this.transactionApi,
      this.streamingApi,
      this.accountCreationApi,
      this.logger);

  KinLogger? _log ;
  KinLogger? get log {
    _log ??= logger.getLogger('$runtimeType') ;
    return _log ;
  }

  final Cache<String> _cache = Cache<String>();

  Future<KinServiceResponse<ServiceConfig>?> _cachedServiceConfig() async {
    return await _cache.resolve("serviceConfig", timeoutOverride: Duration(minutes: 30), fault: (key) {
      return networkOperationsHandler.queueWork('KinServiceImplV4._cachedServiceConfig', () async {
        return await transactionApi.getServiceConfig();
      });
    });
  }

  Future<KinServiceResponse<Hash>?> _cachedRecentBlockHash() async {
    return await _cache.resolve("recentBlockHash", timeoutOverride: Duration(minutes: 2), fault: (key) {
      return networkOperationsHandler.queueWork('KinServiceImplV4._cachedRecentBlockHash', () async {
        return await transactionApi.getRecentBlockHash();
      });
    });
  }


  Future<KinServiceResponse<int>?> _cachedMinRentExemption() async {
    return await _cache.resolve("minRentExemption", timeoutOverride: Duration(minutes: 30), fault: (key) {
      return networkOperationsHandler.queueWork('KinServiceImplV4._cachedMinRentExemption', () async {
        return await transactionApi.getMinimumBalanceForRentExemption( TokenProgram().accountSize );
      });
    });
  }

  @override
  Future<KinAccount?> getAccount(KinAccountId accountId) async {
    return networkOperationsHandler.queueWork('KinServiceImplV4.getAccount', () async {
      var response = await accountApi.getAccount(accountId);

      switch(response.type) {
        case KinServiceResponseType.ok:
          {
            if (response.payload == null) throw IllegalResponseError();
            return response.payload;
          }
        case KinServiceResponseType.notFound: {
          throw ItemNotFoundError();
        }
        case KinServiceResponseType.undefinedError: {
          throw UnexpectedServiceError(response.error);
        }
        case KinServiceResponseType.transientFailure: {
          throw TransientFailure(response.error);
        }
        case KinServiceResponseType.upgradeRequiredError: {
          throw SDKUpgradeRequired(response.error);
        }
        default: throw StateError("Can't handle response type: ${response.type}");
      }
    });
  }

  @override
  Future<List<KinTransaction>?> getLatestTransactions(KinAccountId kinAccountId) async {
    return networkOperationsHandler.queueWork('KinServiceImplV4.getLatestTransactions', () async {
      var response = await transactionApi.getTransactionHistory(kinAccountId) ;

      switch(response.type) {
        case KinServiceResponseType.ok: {
          if (response.payload == null) throw IllegalResponseError();
          return response.payload ;
        }
        case KinServiceResponseType.notFound: {
          throw ItemNotFoundError();
        }
        case KinServiceResponseType.undefinedError: {
          throw UnexpectedServiceError(response.error);
        }
        case KinServiceResponseType.transientFailure: {
          throw TransientFailure(response.error);
        }
        case KinServiceResponseType.upgradeRequiredError: {
          throw SDKUpgradeRequired(response.error);
        }
        default: throw StateError("Can't handle response type: ${response.type}");
      }
    });
  }

  @override
  Future<KinTransaction> buildAndSignTransaction(PrivateKey ownerKey, PublicKey sourceKey, int nonce, List<KinPaymentItem> paymentItems, KinMemo? memo, List<Instruction?> createAccountInstructions, List<PrivateKey?> additionalSigners) {
    log!.log("buildAndSignTransaction: ownerKey: $ownerKey ; sourceKey: $sourceKey ; paymentItems: $paymentItems ; memo: $memo ;");

    return networkOperationsHandler.queueWork('buildAndSignTransaction', () async {
      ServiceConfig? serviceConfig ;
      Hash? recentBlockHash ;
      try {
        var ret = await Future.wait([
          _cachedServiceConfig(),
          _cachedRecentBlockHash(),
        ]);

        serviceConfig = ret[0]!.payload as ServiceConfig?;
        recentBlockHash = ret[1]!.payload as Hash?;
      }
      catch(e) {
        StateError("Pre-requisite response failed! $e");
      }

      var ownerAccount = ownerKey.asPublicKey();
      PublicKey subsidizer = serviceConfig!.subsidizerAccount.toKeyPair().asPublicKey() ;
      var programKey = serviceConfig.tokenProgram.toKeyPair().asPublicKey();

      var paymentInstructions = paymentItems.map((paymentItem) {
        var destinationAccount = paymentItem.destinationAccount.toKeyPair().asPublicKey();

        return TokenProgramTransfer(
            sourceKey,
            destinationAccount,
            ownerAccount,
            paymentItem.amount,
            programKey = programKey
        ).instruction ;
      });

      var memoInstruction = memo != KinMemo.none
          ? (memo!.type is KinMemoTypeNoEncoding
              ? MemoProgramBase64EncodedMemo.fromBytes(memo.rawValue!)
                  .instruction
              : MemoProgramRawMemo(memo.rawValue).instruction)
          : null;

      var tx = Transaction.newTransaction(
        subsidizer,
        [memoInstruction, ...(paymentInstructions.toList()), ...(createAccountInstructions.toList())].whereNotNull(),
      ).copyAndSetRecentBlockhash(recentBlockHash).copyAndSign([ownerKey]);

      var kinTransaction = SolanaKinTransaction(
          tx.marshal(), null,
          networkEnvironment,
          paymentItems.toInvoiceList()
      );


      log!.log('serviceConfig: $serviceConfig');
      log!.log('recentBlockHash: $recentBlockHash');
      log!.log('ownerAccount: $ownerAccount');
      log!.log('sourceOfFundsAccount: $sourceKey');
      log!.log('transactionHexString: ${kinTransaction.bytesValue.toHexString()}');

      return kinTransaction ;
    });
  }

  @override
  Future<KinTransaction> buildSignAndSubmitTransaction(Future<KinTransaction> Function() buildAndSignTransaction) async {
    var ret = await buildAndSignTransaction();
    return submitTransaction(ret);
  }

  @override
  FutureOr<bool> canWhitelistTransactions() => true ;

  @override
  Future<KinAccount?> createAccount(KinAccountId accountId, PrivateKey signer) {
    return networkOperationsHandler.queueWork('KinServiceImplV4.createAccount', () async {
      try {
        var ret = await Future.wait([
          _cachedServiceConfig(),
          _cachedRecentBlockHash(),
          _cachedMinRentExemption()
        ]);
        log!.log("createAccount:");

        var serviceConfig = ret[0]!.payload as ServiceConfig;
        var recentBlockHash = ret[1]!.payload as Hash?;
        var minRentExemption = ret[2]!.payload as int?;

        var tokenAccountSeed = signer
            .toSigningKeyPair()
            .rawSecretSeed!
            .toSha256();
        var tokenAccount = KeyPair.fromSecretSeedBytes(tokenAccountSeed)
            .asPrivateKey();
        var tokenAccountPub = tokenAccount.asPublicKey();

        var subsidizer = serviceConfig.subsidizerAccount.toKeyPair()
            .asPublicKey();
        var owner = signer.asPublicKey();
        var programKey = serviceConfig.tokenProgram.toKeyPair().asPublicKey();
        var mint = serviceConfig.token.toKeyPair().asPublicKey();

        log!.log("- subsidizer: $subsidizer");
        log!.log("- owner: $owner");
        log!.log("- programKey: $programKey");
        log!.log("- mint: $mint");

        var transaction = Transaction.newTransaction(subsidizer, [
          CreateAccount(
            subsidizer,
            tokenAccountPub,
            programKey,
            minRentExemption,
            TokenProgram().accountSize,
          ).instruction,
          TokenProgramInitializeAccount(
            tokenAccountPub,
            mint,
            owner,
            programKey,
          ).instruction,
          SetAuthority(
            tokenAccountPub,
            owner,
            subsidizer,
            TokenProgramAuthorityTypeCloseAccount(),
            programKey,
          ).instruction
        ]).copyAndSetRecentBlockhash(recentBlockHash).copyAndSign(
            [tokenAccount, signer]);

        log!.log("- serviceConfig: $serviceConfig");
        log!.log("- recentBlockHash: $recentBlockHash");
        log!.log("- minRentExemption: $minRentExemption");
        log!.log("- createTransaction: ${transaction.marshal().toHex()}");

        var response = await accountCreationApi.createAccountV4(transaction);

        if (response.type == KinServiceResponseType.ok) {
          var account = response.payload;
          if (account != null) {
            return account;
          } else {
            throw IllegalResponseError();
          }
        }
        else if (response.type == KinServiceResponseType.exists) {
          var account = response.payload;
          if (account != null) {
            return account;
          } else {
            return getAccount(accountId);
          }
        }
        else if (response.type == KinServiceResponseType.badNonce) {
          throw TransientFailure(
              StateError('Bad Nonce: RecentBlockhash invalid'));
        }
        else if (response.type == KinServiceResponseType.transientFailure) {
          throw TransientFailure(response.error);
        }
        else if (response.type == KinServiceResponseType.undefinedError) {
          throw UnexpectedServiceError(response.error);
        }
        else if (response.type == KinServiceResponseType.upgradeRequiredError) {
          throw SDKUpgradeRequired();
        }
        else if (response.type == KinServiceResponseType.payerRequired) {
          throw UnexpectedServiceError(
              StateError('PayerRequired: no subsidizer set'));
        }
        else {
          throw StateError("Can't handle response type: ${response.type}");
        }
      } on TransientFailure {
        invalidateBlockhashCache();
        rethrow ;
      }
    });
  }

  @override
  Future<KinTransaction?> getTransaction(TransactionHash transactionHash) async {
    return networkOperationsHandler.queueWork('KinServiceImplV4.getTransaction', () async {
      var response = await transactionApi.getTransaction(transactionHash);

      if(response.type == KinServiceResponseType.ok) {
        if(response.payload != null) {
          return response.payload;
        }
        else{
          throw IllegalResponseError(response.error);
        }
      }
      else if (response.type == KinServiceResponseType.notFound) {
        throw ItemNotFoundError(response.error);
      }
      else {
        throw UnexpectedServiceError(response.error);
      }
    });
  }

  @override
  Future<List<KinTransaction>?> getTransactionPage(KinAccountId kinAccountId, PagingToken? pagingToken, KinServiceOrder order) async {
    return networkOperationsHandler.queueWork('KinServiceImplV4.getTransactionPage', () async {
      var response = await transactionApi.getTransactionHistory(kinAccountId, pagingToken: pagingToken, order: order);

      if(response.type == KinServiceResponseType.ok) {
        if (response.payload != null) {
          return response.payload;
        }
        else {
          throw IllegalResponseError(response.error);
        }
      }
      else if (response.type == KinServiceResponseType.undefinedError) {
        throw UnexpectedServiceError(response.error);
      }
      else if (response.type == KinServiceResponseType.transientFailure) {
        throw TransientFailure(response.error);
      }
      else if (response.type == KinServiceResponseType.upgradeRequiredError) {
        throw SDKUpgradeRequired();
      }
      else {
        throw UnexpectedServiceError(response.error);
      }
    });
  }

  @override
  void invalidateBlockhashCache() {
      _cache.invalidate("recentBlockHash");
  }

  @override
  Future<List<PublicKey>> resolveTokenAccounts(KinAccountId accountId) async {
    var cacheKey = "resolvedAccounts:${accountId.stellarBase32Encode()}";

    List<PublicKey>? tokenAccounts;

    try {
      tokenAccounts = await _cache.resolve(cacheKey, fault: (k) async {
        return networkOperationsHandler.queueWork(
            'KinServiceImplV4.resolveTokenAccounts', () async {
          var response = await accountApi.resolveTokenAccounts(accountId);

          if (response.type == KinServiceResponseType.ok) {
            return response.payload!;
          }
          else if (response.type == KinServiceResponseType.undefinedError) {
            throw UnexpectedServiceError(response.error);
          }
          else if (response.type == KinServiceResponseType.transientFailure) {
            throw TransientFailure(response.error);
          }
          else
          if (response.type == KinServiceResponseType.upgradeRequiredError) {
            throw SDKUpgradeRequired();
          }
          else {
            throw StateError("Can't handle response.type: ${ response.type }");
          }
        });
      });

      return tokenAccounts ?? <PublicKey>[];
    }
    finally {
      if (tokenAccounts == null || tokenAccounts.isEmpty) {
        _cache.invalidate(cacheKey);
      }
    }
  }

  @override
  Observer<KinAccount> streamAccount(KinAccountId kinAccountId) {
    return streamingApi!.streamAccount(kinAccountId);
  }

  @override
  Observer<KinTransaction> streamNewTransactions(KinAccountId kinAccountId) {
    return streamingApi!.streamNewTransactions(kinAccountId);
  }

  @override
  Future<KinTransaction> submitTransaction(KinTransaction transaction) async {
    return networkOperationsHandler.queueWork('KinServiceImplV4.submitTransaction', () async {
      var response = await transactionApi.submitTransaction(
        Transaction.unmarshal(transaction.bytesValue),
        transaction.invoiceList,
      );

      if (response.type == KinServiceResponseType.ok) {
        return response.payload!;
      }
      else if (response.type == KinServiceResponseType.insufficientFee) {
        throw InsufficientFeeInRequestError(response.error);
      }
      else if (response.type == KinServiceResponseType.badSequenceNumber) {
        throw BadSequenceNumberInRequestError(response.error);
      }
      else if (response.type == KinServiceResponseType.noAccount) {
        throw UnknownAccountInRequestError(response.error);
      }
      else if (response.type == KinServiceResponseType.insufficientBalance) {
        throw InsufficientBalanceForSourceAccountInRequestError(response.error);
      }
      else if (response.type == KinServiceResponseType.invoiceError) {
        throw InvoiceErrorsInRequest(response.error);
      }
      else if (response.type == KinServiceResponseType.webhookRejected) {
        throw WebhookRejectedTransactionError(response.error);
      }
      else if (response .type == KinServiceResponseType.undefinedError) {
        throw UnexpectedServiceError(response.error);
      }
      else if (response.type == KinServiceResponseType.transientFailure) {
        throw TransientFailure(response.error);
      }
      else if (response.type == KinServiceResponseType.upgradeRequiredError) {
        throw SDKUpgradeRequired(response.error);
      }
      else {
        throw UnexpectedServiceError(response.error);
      }
    });
  }

  @override
  Future<List<KinTokenAccountInfo>> mergeTokenAccounts(KinAccountId accountId, PrivateKey signer, AppIdx appIdx, [bool shouldCreateAssociatedAccount = true]) {
    // TODO: implement mergeTokenAccounts
    throw UnimplementedError();
  }

}