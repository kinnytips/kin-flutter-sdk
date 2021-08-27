

import 'dart:async';

import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_memo.dart';
import 'package:kin_base/base/models/kin_payment_item.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/solana/instruction.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/network/api/kin_transaction_api.dart';
import 'package:kin_base/base/network/api/kin_account_api.dart';
import 'package:kin_base/base/network/api/kin_streaming_api.dart';
import 'package:kin_base/base/network/api/kin_account_creation_api.dart';
import 'package:kin_base/base/network/api/kin_transaction_whitelisting_api.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/base/tools/cache.dart';
import 'package:kin_base/base/tools/kin_logger.dart';
import 'package:kin_base/base/tools/network_operations_handler.dart';
import 'package:kin_base/base/tools/observers.dart';

import 'kin_service.dart';

class KinServiceImpl extends KinService {

  final NetworkEnvironment networkEnvironment ;
  final NetworkOperationsHandler networkOperationsHandler ;
  final KinAccountApi accountApi ;
  final KinTransactionApi transactionApi ;
  final KinStreamingApi streamingApi ;
  final KinAccountCreationApi accountCreationApi ;
  final KinTransactionWhitelistingApi transactionWhitelistingApi ;
  final KinLoggerFactory logger;

  KinServiceImpl(
      this.networkEnvironment,
      this.networkOperationsHandler,
      this.accountApi,
      this.transactionApi,
      this.streamingApi,
      this.accountCreationApi,
      this.transactionWhitelistingApi,
      this.logger);

  @override
  Future<KinTransaction> buildAndSignTransaction(PrivateKey ownerKey, PublicKey sourceKey, int nonce, List<KinPaymentItem> paymentItems, KinMemo? memo,
      List<Instruction> createAccountInstructions,
      List<PrivateKey> additionalSigners) {
    // TODO: implement buildAndSignTransaction
    throw UnimplementedError();
  }

  @override
  Future<KinTransaction> buildSignAndSubmitTransaction(Future<KinTransaction> Function() buildAndSignTransaction) async {
    var ret = await buildAndSignTransaction();
    return submitTransaction(ret);
  }

  @override
  FutureOr<bool> canWhitelistTransactions() => transactionWhitelistingApi.isWhitelistingAvailable;

  @override
  Future<KinAccount> createAccount(KinAccountId accountId, PrivateKey signer) {
    // TODO: implement createAccount
    throw UnimplementedError();
  }

  Future<Pair<List<Instruction>, PrivateKey>> createTokenAccountForDestinationOwner(PublicKey owner) {
    throw UnimplementedError();
  }

  @override
  Future<KinAccount> getAccount(KinAccountId accountId) {
    // TODO: implement getAccount
    throw UnimplementedError();
  }

  @override
  Future<List<KinTransaction>> getLatestTransactions(KinAccountId kinAccountId) {
    // TODO: implement getLatestTransactions
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
  Future<List<KinTransaction>> getTransactionPage(KinAccountId kinAccountId, PagingToken? pagingToken, KinServiceOrder order) {
    // TODO: implement getTransactionPage
    throw UnimplementedError();
  }

  @override
  void invalidateBlockhashCache() {
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