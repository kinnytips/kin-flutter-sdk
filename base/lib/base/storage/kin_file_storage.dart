import 'dart:convert';

import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_balance.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/sha_224_hash.dart';
import 'package:kin_base/base/network/api/agora/proto_to_model_v4.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/kin_transactions.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/storage/file_storage.dart';
import 'package:kin_base/base/tools/executor_service.dart';
import 'package:kin_base/base/tools/extensions.dart' show ListKinTransactionExtension;
import 'package:kin_base/base/tools/hex.dart';
import 'package:kin_base/models/agora/protobuf/common/v3/model.pb.dart' as models ;
import 'package:kin_base_storage/kin_base_storage.dart' as base_storage;

import 'package:kin_base/base/tools/extensions.dart' show ListExtension;

import 'kin_storage_extension.dart';
import 'storage.dart';

class KinFileStorage implements Storage {
  static final fileNameForAccountInfo = "account_info";
  static final directoryNameForAllAccounts = "kin_accounts";
  static final fileNameForConfig = "config";

  final String _filesDir;

  final NetworkEnvironment? _networkEnvironment;

  final ExecutorServices _executors;

  final FileStorage _storageIO = FileStorage.create();

  KinFileStorage(
      this._filesDir, this._networkEnvironment, [ExecutorServices? executors])
      : _executors = executors ?? ExecutorServices();

  @override
  bool addAccount(KinAccount? kinAccount) {
    return _storageIO.writeToFile(
        _directoryForAccount(kinAccount!.id),
        fileNameForAccountInfo,
        kinAccount.toStorageKinAccount().writeToBuffer());
  }


  String _directoryForAccount(KinAccountId accountId) {
    return _directoryForAllAccounts() + "${accountId.javaHashCode}/";
  }

  String _directoryForAllAccounts() =>
      "${_envDirectory()}/$directoryNameForAllAccounts/";

  String _envDirectory() {
    var bytes = utf8.encode(_networkEnvironment!.networkPassphrase);
    var hex = HexEncoder().convert(bytes);
    return "$_filesDir/env/$hex";
  }

  @override
  Future<List<InvoiceList?>> addInvoiceLists(KinAccountId accountId, List<InvoiceList?> invoiceLists) async {
    if (invoiceLists.isEmpty) return invoiceLists ;

    var invoiceListsMap = await getInvoiceListsMapForAccountId(accountId) ;

    for (var invoice in invoiceLists) {
      invoiceListsMap[invoice!.id] = invoice ;
    }

    _storageIO.writeToFile(
        _directoryForInvoices(accountId),
        _fileNameForInvoices(accountId),
        invoiceListsMap.toInvoices().writeToBuffer()
    );

    return invoiceListsMap.values.toList();
  }

  @override
  KinAccount? advanceSequence(KinAccountId id) {
    var storedAccount = getAccount(id) ;
    if (storedAccount == null) return null ;

    var storedStatus = storedAccount.status is KinAccountStatusRegistered ? storedAccount.status as KinAccountStatusRegistered : null ;
    var sequence = storedStatus?.sequence ?? 0;

    var newStatus = KinAccountStatusRegistered(sequence + 1);

    var updatedAccount = storedAccount.copy(
        key: storedAccount.key,
        balance: storedAccount.balance,
        status: newStatus
    );

    updateAccount(updatedAccount);

    return updatedAccount ;
  }

  @override
  Future<bool> deleteAllStorage([KinAccountId? accountId]) {
    // TODO: implement deleteAllStorage
    throw UnimplementedError();
  }

  @override
  KinAccount? getAccount(KinAccountId accountId) {
    var directoryForAccount = _directoryForAccount(accountId);
    var account = this._getAccountFromAccountDirectory(directoryForAccount) ;
    return account;
  }

  @override
  List<KinAccountId> getAllAccountIds() {
    var accountDirectories = _storageIO.subdirectories(_directoryForAllAccounts());

    var accountIds = accountDirectories
        .map((d) => _getAccountFromAccountDirectory(d))
        .where((e) => e != null)
        .map((e) => e!.id)
        .toList();

    return accountIds ;
  }

  @override
  List<KinAccount?> getAllAccounts() {
    var accountDirectories = _storageIO.subdirectories(_directoryForAllAccounts());

    var accounts = accountDirectories
        .map((d) => _getAccountFromAccountDirectory(d))
        .where((e) => e != null)
        .toList();

    return accounts ;
  }

  KinAccount? _getAccountFromAccountDirectory(String directory) {
    var bytes = _storageIO.readFile(directory, fileNameForAccountInfo);
    if (bytes.isEmpty) return null;

    try {
      var storageKinAccount = base_storage.KinAccount.fromBuffer(bytes);
      return storageKinAccount.toKinAccount();
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<int> getMinApiVersion() async {
    return 3 ;
  }

  @override
  Future<QuarkAmount?> getMinFee() async {
    return null;
  }

  @override
  String getOrCreateCID() {
    throw UnimplementedError();
  }

  @override
  Future<KinAccount?> getStoredAccount(KinAccountId accountId) async {
    return _executors.sequentialIO.execute(() => getAccount(accountId));
  }

  @override
  Future<KinTransactions?> getStoredTransactions(KinAccountId accountId) async {
    var invoiceListsMap = await getInvoiceListsMapForAccountId(accountId);
    var transactions = getTransactions(accountId) ;
    if (transactions == null) return null ;

    var list = transactions.items.map((t) {
      var memo = t.memo!.getAgoraMemo();
      if (memo != null) {
        if (t is SolanaKinTransaction) {
          var invoiceListId = InvoiceListId(SHA224Hash.just(memo.foreignKeyBytes!));
          var invoiceList = invoiceListsMap[invoiceListId];
          return t.copyWithInvoiceList(invoiceList);
        }
        else {
          throw StateError("Can't handle transaction of type: $t");
        }
      }
      else {
        return t ;
      }
    }).toList() ;

    var transactionsWithInvoices = KinTransactions(list) ;
    return transactionsWithInvoices ;
  }

  Future<Map<InvoiceListId, InvoiceList?>> getInvoiceListsMapForAccountId(KinAccountId account) async {
    var bytes = _storageIO.readFile(
        _directoryForInvoices(account),
        _fileNameForInvoices(account)
    );

    if (bytes.isEmpty) {
      return <InvoiceListId, InvoiceList?>{};
    } else {
      var invoices = base_storage.Invoices.fromBuffer(bytes);

      Map<InvoiceListId, InvoiceList?> map = invoices.invoiceLists.map((key, value) {
        var invoiceListId = InvoiceListId( SHA224Hash(key) );
        var invoiceList = models.InvoiceList.fromBuffer(value.networkInvoiceList).toInvoiceList() ;
        return MapEntry(invoiceListId,  invoiceList );
      });

      return map ;
    }
  }

  String _directoryForInvoices(KinAccountId accountId) {
    return "${_directoryForAccount(accountId)}_invoices";
  }

  String _fileNameForInvoices(KinAccountId accountId) {
    return "${accountId.javaHashCode}_invoices";
  }

  @override
  KinTransactions? getTransactions(KinAccountId key) {
    var transactionsDir = _directoryForTransactions(key);
    var transactionsFile = _fileNameForTransactions(key);

    var transactions = _getTransactionsFromFile(transactionsDir, transactionsFile);

    return transactions ;
  }

  KinTransactions? _getTransactionsFromFile(String directory, String fileName){
    var bytes = _storageIO.readFile(directory, fileName);
    if (bytes.isEmpty) return null;

    try {
      var storageTransaction = base_storage.KinTransactions.fromBuffer(bytes);
      return storageTransaction.toKinTransactions(_networkEnvironment);
    } catch (e) {
      print(e);
      return null;
    }
  }

  String _directoryForTransactions(KinAccountId accountId) {
    return "${_directoryForAccount(accountId)}_transactions";
  }


  String _fileNameForTransactions(KinAccountId accountId) {
    return "${accountId.javaHashCode}_transactions" ;
  }

  @override
  Future<List<KinTransaction>> insertNewTransactionInStorage(KinAccountId accountId, KinTransaction newTransaction) async {
    var storedTransactions = await getStoredTransactions(accountId);
    var items = storedTransactions?.items ?? <KinTransaction>[] ;

    var list = [newTransaction , ...items].whereNotNull<KinTransaction>();

    return storeTransactions(accountId, list);
  }

  @override
  void putTransactions(KinAccountId key, KinTransactions transactions) {
    // TODO: implement putTransactions
  }

  @override
  bool removeAccount(KinAccountId accountId) {
    // TODO: implement removeAccount
    throw UnimplementedError();
  }

  @override
  bool removeAllInvoices(KinAccountId account) {
    // TODO: implement removeAllInvoices
    throw UnimplementedError();
  }

  @override
  bool removeAllTransactions(KinAccountId key) {
    // TODO: implement removeAllTransactions
    throw UnimplementedError();
  }

  @override
  bool removeServiceConfig() {
    // TODO: implement removeServiceConfig
    throw UnimplementedError();
  }

  @override
  Future<int> setMinApiVersion(int apiVersion) {
    // TODO: implement setMinApiVersion
    throw UnimplementedError();
  }

  @override
  Future<QuarkAmount> setMinFee(QuarkAmount minFee) {
    // TODO: implement setMinFee
    throw UnimplementedError();
  }

  @override
  Future<List<KinTransaction>> storeTransactions(KinAccountId accountId, List<KinTransaction> transactions) async {
    if ( transactions.isEmpty ) return transactions ;

    var future = _executors.sequentialIO.execute(() async {
      await addInvoiceLists(accountId, transactions.map((t) => t.invoiceList).where((t) => t != null).toList());

      putTransactions(accountId, KinTransactions(
        transactions,
        transactions.findHeadHistoricalTransaction(),
        transactions.findTailHistoricalTransaction()
      ));

      return transactions ;
    });

    var ret = await future ;

    return ret ?? <KinTransaction>[] ;
  }

  @override
  bool updateAccount(KinAccount account) {
    // If the account is already stored with private key, when updating this account with a
    // public key, keep the private key.
    var existingAccount = getAccount(account.id);

    KinAccount mergedAccount ;
    if (existingAccount != null && existingAccount.key is PrivateKey) {
      mergedAccount = existingAccount.copy(
          tokenAccounts: account.tokenAccounts,
          balance: account.balance,
          status: account.status
      );
    }
    else {
      mergedAccount = account ;
    }

    return _storageIO.writeToFile(
        _directoryForAccount(account.id),
        fileNameForAccountInfo,
        mergedAccount.toStorageKinAccount().writeToBuffer());
  }

  @override
  Future<KinAccount> updateAccountBalance(KinAccountId accountId, KinBalance balance) async {
    var storedAccount = await getStoredAccount(accountId) ;

    if (storedAccount == null) {
      throw StateError("Trying to update balance of not stored account: $accountId");
    }

    var account2 = storedAccount.copy(balance: balance);

    updateAccount(account2);

    return account2 ;
  }

  @override
  Future<KinAccount> updateAccountInStorage(KinAccount account) async {
    var accountId = account.id;
    var accountInStorage = await getStoredAccount(accountId);

    if (accountInStorage == null) {
      throw StateError("Trying to update not stored account: $accountId");
    }

    var accountToStore = accountInStorage.merge(account);

    if (updateAccount(accountToStore)) {
      return accountToStore ;
    } else {
      throw Exception("Failed to update Account in storage");
    }
  }

  @override
  Future<List<KinTransaction>> upsertNewTransactionsInStorage(KinAccountId accountId, List<KinTransaction>? newTransactions) async {
    var kinTransactions = await getStoredTransactions(accountId);

    var storedTransactions = kinTransactions?.items ?? <KinTransaction>[] ;
    storedTransactions.retainWhere((storedTxn) => newTransactions!.where((newTxn) => newTxn.transactionHash == storedTxn.transactionHash ).isEmpty) ;

    var allTxn = List<KinTransaction>.from([ ...newTransactions! , ...storedTransactions ]);

    return storeTransactions(accountId, allTxn);
  }

  @override
  Future<List<KinTransaction>> upsertOldTransactionsInStorage(KinAccountId accountId, List<KinTransaction>? oldTransactions) {
    // TODO: implement upsertOldTransactionsInStorage
    throw UnimplementedError();
  }

}
