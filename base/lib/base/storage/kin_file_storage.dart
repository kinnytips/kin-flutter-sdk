import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_balance.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/sha_224_hash.dart';
import 'package:kin_base/base/network/api/agora/proto_to_model_v4.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/kin_transactions.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/tools/executor_service.dart';
import 'package:kin_base/base/tools/hex.dart';
import 'package:kin_base/models/agora/protobuf/common/v3/model.pb.dart' as models ;
import 'package:kin_base_storage/kin_base_storage.dart' as base_storage;
import 'package:path/path.dart' as path;

import 'kin_storage_extension.dart';
import 'storage.dart';

class KinFileStorage implements Storage {
  static final fileNameForAccountInfo = "account_info";
  static final directoryNameForAllAccounts = "kin_accounts";
  static final fileNameForConfig = "config";

  final String _filesDir;

  final NetworkEnvironment _networkEnvironment;

  final ExecutorServices _executors;

  KinFileStorage(
      this._filesDir, this._networkEnvironment, [ExecutorServices executors])
      : _executors = executors ?? ExecutorServices();

  @override
  bool addAccount(KinAccount kinAccount) {
    return _writeToFile(
        _directoryForAccount(kinAccount.id),
        fileNameForAccountInfo,
        kinAccount.toStorageKinAccount().writeToBuffer());
  }


  String _directoryForAccount(KinAccountId accountId) {
    return _directoryForAllAccounts() + "${accountId.hashCode}/";
  }

  String _directoryForAllAccounts() =>
      "${_envDirectory()}/$directoryNameForAllAccounts/";

  String _envDirectory() {
    var bytes = utf8.encode(_networkEnvironment.networkPassphrase);
    var hex = HexEncoder().convert(bytes);
    return "$_filesDir/env/$hex";
  }

  bool _writeToFile(String directory, String fileName, Uint8List body) {
    var file = File(path.join(directory, fileName));

    var parent = file.parent;
    if (!parent.existsSync()) {
      parent.createSync(recursive: true);
    }

    file.writeAsBytesSync(body);

    return true;
  }

  bool _removeFile(String directory, String fileName) {
    var file = File(path.join(directory, fileName));

    if (!file.existsSync()) return true;

    file.deleteSync();

    return true;
  }

  Uint8List _readFile(String directory, String fileName) {
    var file = File(path.join(directory, fileName));

    if (!file.existsSync()) return Uint8List(0);

    return file.readAsBytesSync();
  }

  List<String> _subdirectories(String directory) {
    var dir = Directory(directory);

    if (!dir.existsSync()) return <String>[];

    return dir.listSync().map((e) => e.path).toList();
  }

  @override
  Future<List<InvoiceList>> addInvoiceLists(KinAccountId accountId, List<InvoiceList> invoiceLists) {
    // TODO: implement addInvoiceLists
    throw UnimplementedError();
  }

  @override
  KinAccount advanceSequence(KinAccountId id) {
    // TODO: implement advanceSequence
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteAllStorage([KinAccountId accountId]) {
    // TODO: implement deleteAllStorage
    throw UnimplementedError();
  }

  @override
  KinAccount getAccount(KinAccountId accountId) {
    var account = this._getAccountFromAccountDirectory(_directoryForAccount(accountId)) ;
    return account;
  }

  @override
  List<KinAccountId> getAllAccountIds() {
    var accountDirectories = _subdirectories(_directoryForAllAccounts());

    var accountIds = accountDirectories.map((d) => _getAccountFromAccountDirectory(d)).map((e) => e.id).toList();

    return accountIds ;
  }

  KinAccount _getAccountFromAccountDirectory(String directory) {
    var bytes = _readFile(directory, fileNameForAccountInfo);
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
  Future<int> getMinApiVersion() {
    // TODO: implement getMinApiVersion
    throw UnimplementedError();
  }

  @override
  Future<QuarkAmount> getMinFee() {
    // TODO: implement getMinFee
    throw UnimplementedError();
  }

  @override
  String getOrCreateCID() {
    // TODO: implement getOrCreateCID
    throw UnimplementedError();
  }

  @override
  Future<KinAccount> getStoredAccount(KinAccountId accountId) async {
    return _executors.sequentialIO.execute(() => getAccount(accountId));
  }

  @override
  Future<KinTransactions> getStoredTransactions(KinAccountId accountId) async {
    var invoiceListsMap = await getInvoiceListsMapForAccountId(accountId);
    var transactions = getTransactions(accountId) ;
    if (transactions == null) return null ;

    var list = transactions.items.map((t) {
      var memo = t.memo.getAgoraMemo();
      if (memo != null) {
        if (t is SolanaKinTransaction) {
          var invoiceListId = InvoiceListId(SHA224Hash.just(memo.foreignKeyBytes));
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

  Future<Map<InvoiceListId, InvoiceList>> getInvoiceListsMapForAccountId(KinAccountId account) async {
    var bytes = _readFile(
        _directoryForInvoices(account),
        _fileNameForInvoices(account)
    );

    if (bytes.isEmpty) {
      return <InvoiceListId, InvoiceList>{};
    } else {
      var invoices = base_storage.Invoices.fromBuffer(bytes);

      Map<InvoiceListId, InvoiceList> map = invoices.invoiceLists.map((key, value) {
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
    return "${accountId.hashCode}_invoices";
  }

  @override
  KinTransactions getTransactions(KinAccountId key) {
    var transactionsDir = _directoryForTransactions(key);
    var transactionsFile = _fileNameForTransactions(key);

    var transactions = _getTransactionsFromFile(transactionsDir, transactionsFile);

    return transactions ;
  }

  KinTransactions _getTransactionsFromFile(String directory, String fileName){
    var bytes = _readFile(directory, fileName);
    if (bytes.isEmpty) return null;

    try {
      var storageTransaction = base_storage.KinTransactions.fromBuffer(bytes);
      return storageTransaction.toKinTransactions();
    } catch (e) {
      print(e);
      return null;
    }
  }

  /*(
    private fun getTransactionsFromFile(directory: String, fileName: String): KinTransactions? {
        val bytes = readFile(directory, fileName)
        if (bytes.isEmpty()) return null

        try {
            val storageTransaction = StorageKinTransactions.parseFrom(bytes)
            return storageTransaction.toKinTransactions()
        } catch (e: InvalidProtocolBufferException) {
            e.printStackTrace()
            return null
        }
    }
   */

  String _directoryForTransactions(KinAccountId accountId) {
    return "${_directoryForAccount(accountId)}_transactions";
  }


  String _fileNameForTransactions(KinAccountId accountId) {
    return "${accountId.hashCode}_transactions" ;
  }

  @override
  Future<List<KinTransaction>> insertNewTransactionInStorage(KinAccountId accountId, KinTransaction newTransaction) {
    // TODO: implement insertNewTransactionInStorage
    throw UnimplementedError();
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
  Future<List<KinTransaction>> storeTransactions(KinAccountId accountId, List<KinTransaction> transactions) {
    // TODO: implement storeTransactions
    throw UnimplementedError();
  }

  @override
  bool updateAccount(KinAccount account) {
    // TODO: implement updateAccount
    throw UnimplementedError();
  }

  @override
  Future<KinAccount> updateAccountBalance(KinAccountId accountId, KinBalance balance) {
    // TODO: implement updateAccountBalance
    throw UnimplementedError();
  }

  @override
  Future<KinAccount> updateAccountInStorage(KinAccount account) {
    // TODO: implement updateAccountInStorage
    throw UnimplementedError();
  }

  @override
  Future<List<KinTransaction>> upsertNewTransactionsInStorage(KinAccountId accountId, List<KinTransaction> newTransactions) {
    // TODO: implement upsertNewTransactionsInStorage
    throw UnimplementedError();
  }

  @override
  Future<List<KinTransaction>> upsertOldTransactionsInStorage(KinAccountId accountId, List<KinTransaction> oldTransactions) {
    // TODO: implement upsertOldTransactionsInStorage
    throw UnimplementedError();
  }

}
