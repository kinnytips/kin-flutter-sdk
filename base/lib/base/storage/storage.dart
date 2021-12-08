import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/kin_balance.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/kin_transactions.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';


typedef StorageBuilder = Storage Function({NetworkEnvironment? networkEnvironment});

abstract class Storage {
  bool addAccount(KinAccount? account);

  bool updateAccount(KinAccount account);

  bool removeAccount(KinAccountId accountId);

  KinAccount? getAccount(KinAccountId accountId);

  KinAccount? advanceSequence(KinAccountId id);

  List<KinAccountId> getAllAccountIds();

  List<KinAccount?> getAllAccounts();

  void putTransactions(KinAccountId key, KinTransactions transactions);

  bool removeAllTransactions(KinAccountId key);

  bool removeAllInvoices(KinAccountId account);

  bool removeServiceConfig();

  KinTransactions? getTransactions(KinAccountId key);

  String getOrCreateCID();

  Future<KinTransactions?> getStoredTransactions(KinAccountId accountId);

  Future<List<KinTransaction>> storeTransactions(
      KinAccountId accountId, List<KinTransaction> transactions);

  Future<List<KinTransaction>> upsertNewTransactionsInStorage(
      KinAccountId accountId, List<KinTransaction>? newTransactions);

  Future<List<KinTransaction>> upsertOldTransactionsInStorage(
      KinAccountId accountId, List<KinTransaction>? oldTransactions);

  Future<List<KinTransaction>> insertNewTransactionInStorage(
      KinAccountId accountId, KinTransaction newTransaction);

  Future<List<InvoiceList?>> addInvoiceLists(
      KinAccountId accountId, List<InvoiceList> invoiceLists);

  Future<Map<InvoiceListId, InvoiceList?>> getInvoiceListsMapForAccountId(
      KinAccountId account);

  Future<KinAccount?> getStoredAccount(KinAccountId accountId);

  Future<KinAccount> updateAccountInStorage(KinAccount account);

  Future<KinAccount> updateAccountBalance(
      KinAccountId accountId, KinBalance balance);

  Future<bool> deleteAllStorage([KinAccountId? accountId]);

  Future<int> setMinApiVersion(int apiVersion);

  Future<int> getMinApiVersion();
}
