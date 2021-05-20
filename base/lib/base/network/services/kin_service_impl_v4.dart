

import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_memo.dart';
import 'package:kin_base/base/models/kin_payment_item.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/network/api/kin_account_api.dart';
import 'package:kin_base/base/network/api/kin_account_api_v4.dart';
import 'package:kin_base/base/network/api/kin_account_creation_api_v4.dart';
import 'package:kin_base/base/network/api/kin_streaming_api_v4.dart';
import 'package:kin_base/base/network/api/kin_transaction_api.dart';
import 'package:kin_base/base/network/api/kin_transaction_api_v4.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/base/tools/kin_logger.dart';
import 'package:kin_base/base/tools/network_operations_handler.dart';
import 'package:kin_base/base/tools/observers.dart';

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

  @override
  Future<KinAccount> getAccount(KinAccountId accountId) {

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
    // TODO: implement createAccount
    throw UnimplementedError();
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
  invalidateBlockhashCache() {
    // TODO: implement invalidateBlockhashCache
    throw UnimplementedError();
  }

  @override
  Future<List<PublicKey>> resolveTokenAccounts(KinAccountId accountId) {
    // TODO: implement resolveTokenAccounts
    throw UnimplementedError();
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