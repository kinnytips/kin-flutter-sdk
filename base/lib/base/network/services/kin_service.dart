import 'dart:async';

import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_memo.dart';
import 'package:kin_base/base/models/kin_payment_item.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/paging_token.dart';
import 'package:kin_base/base/tools/observers.dart';

class KinService {
    Future<KinAccount> createAccount(KinAccountId accountId, PrivateKey signer) { }

    Future<KinAccount> getAccount(KinAccountId accountId) { }

    Future<List<PublicKey>> resolveTokenAccounts(KinAccountId accountId) { }

    Future<List<KinTransaction>> getLatestTransactions(KinAccountId kinAccountId) {}

    Future<List<KinTransaction>> getTransactionPage(
        KinAccountId kinAccountId,
        PagingToken pagingToken,
        Order order
    ) { }

    Future<KinTransaction> getTransaction(TransactionHash transactionHash) { } 

    Future<bool> canWhitelistTransactions() { }

    Future<QuarkAmount> getMinFee() { }

    Future<KinTransaction> buildAndSignTransaction(
        PrivateKey ownerKey,
        PublicKey sourceKey,
        int nonce,
        List<KinPaymentItem> paymentItems,
        KinMemo memo,
        QuarkAmount fee
    ) { }

    Future<KinTransaction> submitTransaction(KinTransaction transaction) { }

    Future<KinTransaction> buildSignAndSubmitTransaction(
        Future<KinTransaction> buildAndSignTransaction
    ) { }

    Observer<KinAccount> streamAccount(KinAccountId kinAccountId) { }

    Observer<KinTransaction> streamNewTransactions(KinAccountId kinAccountId) { }

    invalidateBlockhashCache() {}
}

class Order extends KinService {
  Order(int value);
}

class Ascending extends Order {
  Ascending() : super(0);
}

class Descending extends Order {
  Descending() : super(1);
}

class FatalError extends KinService {
  
}

class KinTestService {
    /**
     * Funds an account with a set amount of test Kin.
     */
    Future<KinAccount> fundAccount(KinAccountId accountId) { }
}