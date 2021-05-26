
import 'dart:async';

import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_memo.dart';
import 'package:kin_base/base/models/kin_payment_item.dart';
import 'package:kin_base/base/models/quark_amount.dart';
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
  final KinStreamingApiV4 streamingApi ;
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

  final Cache<String> _cache = Cache<String>();

  Future<KinServiceResponse<ServiceConfig>> _cachedServiceConfig() async {
    return await _cache.resolve("serviceConfig", timeoutOverride: Duration(minutes: 30), fault: (key) {
      return networkOperationsHandler.queueWork('_cachedServiceConfig', () async {
        return await transactionApi.getServiceConfig();
      });
    });
  }

  Future<KinServiceResponse<Hash>> _cachedRecentBlockHash() async {
    return await _cache.resolve("recentBlockHash", timeoutOverride: Duration(minutes: 2), fault: (key) {
      return networkOperationsHandler.queueWork('_cachedServiceConfig', () async {
        return await transactionApi.getRecentBlockHash();
      });
    });
  }


  Future<KinServiceResponse<int>> _cachedMinRentExemption() async {
    return await _cache.resolve("minRentExemption", timeoutOverride: Duration(minutes: 30), fault: (key) {
      return networkOperationsHandler.queueWork('_cachedServiceConfig', () async {
        return await transactionApi.getMinimumBalanceForRentExemption( TokenProgram().accountSize );
      });
    });
  }

  @override
  Future<KinAccount> getAccount(KinAccountId accountId) {
    throw UnimplementedError('!!!getAccount');
  }

  @override
  Future<List<KinTransaction>> getLatestTransactions(KinAccountId kinAccountId) async {
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
  }

  @override
  Future<KinTransaction> buildAndSignTransaction(PrivateKey ownerKey, PublicKey sourceKey, int nonce, List<KinPaymentItem> paymentItems, KinMemo memo, QuarkAmount fee) {
    // TODO: implement buildAndSignTransaction
    throw UnimplementedError();
  }

  @override
  Future<KinTransaction> buildSignAndSubmitTransaction(Future<KinTransaction> buildAndSignTransaction) {
    // TODO: implement buildSignAndSubmitTransaction
    throw UnimplementedError();
  }

  @override
  Future<bool> canWhitelistTransactions() {
    // TODO: implement canWhitelistTransactions
    throw UnimplementedError();
  }

  @override
  Future<KinAccount> createAccount(KinAccountId accountId, PrivateKey signer) {
    return networkOperationsHandler.queueWork('accountApi.resolveTokenAccounts', () async {
      var ret = await Future.wait( [ _cachedServiceConfig() , _cachedRecentBlockHash(), _cachedMinRentExemption() ] );
      var serviceConfig = ret[0].payload as ServiceConfig ;
      var recentBlockHash = ret[1].payload as Hash ;
      var minRentExemption = ret[2].payload as int ;

      var tokenAccountSeed = signer.toSigningKeyPair().rawSecretSeed.toSha256() ;
      var tokenAccount = KeyPair.fromSecretSeedBytes(tokenAccountSeed).asPrivateKey();
      var tokenAccountPub = tokenAccount.asPublicKey();

      var subsidizer = serviceConfig.subsidizerAccount.toKeyPair().asPublicKey();
      var owner = signer.asPublicKey();
      var programKey = serviceConfig.tokenProgram.toKeyPair().asPublicKey();
      var mint = serviceConfig.token.toKeyPair().asPublicKey();

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
      ]).copyAndSetRecentBlockhash(recentBlockHash).copyAndSign([tokenAccount, signer]);

      var response = await accountCreationApi.createAccountV4(transaction) ;

      if (response.type == KinServiceResponseType.ok) {
        var account = response.payload;
        if (account != null) {
          return account ;
        } else {
          throw IllegalResponseError();
        }
      }
      else if (response.type == KinServiceResponseType.exists) {
        var account = response.payload;
        if (account != null) {
          return account ;
        } else {
          return getAccount(accountId);
        }
      }
      else if (response.type == KinServiceResponseType.badNonce) {
        throw TransientFailure(StateError('Bad Nonce: RecentBlockhash invalid')) ;
      }
      else if (response.type == KinServiceResponseType.transientFailure) {
        throw TransientFailure(response.error) ;
      }
      else if (response.type == KinServiceResponseType.undefinedError) {
        throw UnexpectedServiceError(response.error) ;
      }
      else if (response.type == KinServiceResponseType.upgradeRequiredError) {
        throw SDKUpgradeRequired();
      }
      else if (response.type == KinServiceResponseType.payerRequired) {
        throw UnexpectedServiceError(StateError('PayerRequired: no subsidizer set')) ;
      }
      else {
        throw StateError("Can't handle response type: ${response.type}");
      }
    });
  }

  @override
  Future<QuarkAmount> getMinFee() {
    // TODO: implement getMinFee
    throw UnimplementedError();
  }

  @override
  Future<KinTransaction> getTransaction(TransactionHash transactionHash) {
    // TODO: implement getTransaction
    throw UnimplementedError();
  }

  @override
  Future<List<KinTransaction>> getTransactionPage(KinAccountId kinAccountId, PagingToken pagingToken, KinServiceOrder order) {
    // TODO: implement getTransactionPage
    throw UnimplementedError();
  }

  @override
  void invalidateBlockhashCache() {
      _cache.invalidate("recentBlockHash");
  }

  @override
  Future<List<PublicKey>> resolveTokenAccounts(KinAccountId accountId) async {
    var cacheKey = "resolvedAccounts:${accountId.stellarBase32Encode()}";

    var tokenAccounts = await _cache.resolve(cacheKey, fault: (k) async {
      return networkOperationsHandler.queueWork('accountApi.resolveTokenAccounts', () async {
        var response = await accountApi.resolveTokenAccounts(accountId) ;

        if ( response.type == KinServiceResponseType.ok ) {
          return response.payload ;
        }
        else if ( response.type == KinServiceResponseType.undefinedError ) {
          throw UnexpectedServiceError(response.error);
        }
        else if ( response.type == KinServiceResponseType.transientFailure ) {
          throw TransientFailure(response.error);
        }
        else if ( response.type == KinServiceResponseType.upgradeRequiredError ) {
          throw SDKUpgradeRequired();
        }
        else {
          throw StateError("Can't handle response.type: ${ response.type }") ;
        }
      });
    });

    if (tokenAccounts == null || tokenAccounts.isEmpty) {
      _cache.invalidate(cacheKey);
    }

    return tokenAccounts ;
  }

  @override
  Observer<KinAccount> streamAccount(KinAccountId kinAccountId) {
    // TODO: implement streamAccount
    throw UnimplementedError();
  }

  @override
  Observer<KinTransaction> streamNewTransactions(KinAccountId kinAccountId) {
    // TODO: implement streamNewTransactions
    throw UnimplementedError();
  }

  @override
  Future<KinTransaction> submitTransaction(KinTransaction transaction) {
    // TODO: implement submitTransaction
    throw UnimplementedError();
  }

}