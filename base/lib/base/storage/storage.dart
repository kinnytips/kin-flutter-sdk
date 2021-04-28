import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/quark_amount.dart';

abstract class Storage {
  bool addAccount(KinAccount account);

  bool updateAccount(KinAccount account);

  bool removeAccount(KinAccountId accountId);

  KinAccount getAccount(KinAccountId accountId);

  KinAccount advanceSequence(KinAccountId id);

  List<KinAccountId> getAllAccountIds();

  void putTransactions(KinAccountId key, KinTransactions transactions);

  bool removeAllTransactions(KinAccountId key);

  bool removeAllInvoices(KinAccountId account);

  bool removeServiceConfig();

  KinTransactions getTransactions(KinAccountId key);

  String getOrCreateCID();

  Future<KinTransactions> getStoredTransactions(KinAccountId accountId);

  Future<List<KinTransaction>> storeTransactions(
      KinAccountId accountId, List<KinTransaction> transactions);

  Future<List<KinTransaction>> upsertNewTransactionsInStorage(
      KinAccountId accountId, List<KinTransaction> newTransactions);

  Future<List<KinTransaction>> upsertOldTransactionsInStorage(
      KinAccountId accountId, List<KinTransaction> oldTransactions);

  Future<List<KinTransaction>> insertNewTransactionInStorage(
      KinAccountId accountId, KinTransaction newTransaction);

  Future<List<InvoiceList>> addInvoiceLists(
      KinAccountId accountId, List<InvoiceList> invoiceLists);

  Future<Map<InvoiceListId, InvoiceList>> getInvoiceListsMapForAccountId(
      KinAccountId account);

  Future<KinAccount> getStoredAccount(KinAccountId accountId);

  Future<KinAccount> updateAccountInStorage(KinAccount account);

  Future<KinAccount> updateAccountBalance(
      KinAccountId accountId, KinBalance balance);

  Future<QuarkAmount> setMinFee(QuarkAmount minFee);

  Future<QuarkAmount> getMinFee();

  Future<bool> deleteAllStorage(KinAccountId accountId);

  Future<bool> deleteAllStorage();

  Future<int> setMinApiVersion(int apiVersion);

  Future<int> getMinApiVersion();
}
