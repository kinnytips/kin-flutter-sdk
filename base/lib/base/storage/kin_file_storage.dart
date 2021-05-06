import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_balance.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/tools/executor_service.dart';
import 'package:kin_base/base/tools/hex.dart';
import 'package:kin_base_storage/kin_base_storage.dart' as base_storage;
import 'package:path/path.dart' as path;

import 'storage.dart';

class KinFileStorage implements Storage {
  static final fileNameForAccountInfo = "account_info";
  static final directoryNameForAllAccounts = "kin_accounts";
  static final fileNameForConfig = "config";

  final String _filesDir;

  final NetworkEnvironment _networkEnvironment;

  final ExecutorServices _executors;

  KinFileStorage(this._filesDir, this._networkEnvironment, this._executors);

  @override
  bool addAccount(KinAccount kinAccount) {
    return _writeToFile(
        _directoryForAccount(kinAccount.id),
        fileNameForAccountInfo,
        toStorageKinAccount(kinAccount).writeToBuffer());
  }

  base_storage.KinAccount toStorageKinAccount(KinAccount kinAccount) {
    var storageKinAccount = base_storage.KinAccount.create()
      ..balance = toStorageKinBalance(kinAccount.balance);

    var status = kinAccount.status;
    if (status is KinAccountStatusUnregistered) {
      storageKinAccount.status = base_storage.KinAccount_Status.UNREGISTERED;
    } else if (status is KinAccountStatusRegistered) {
      storageKinAccount
        ..status = base_storage.KinAccount_Status.REGISTERED
        ..sequenceNumber = fixnum.Int64(status.sequence);
    }

    var key = kinAccount.key;

    if (key is PublicKey) {
      var publicKey = base_storage.PublicKey.create()..value = key.value;
      storageKinAccount.publicKey = publicKey;
    } else if (key is PrivateKey) {
      var privateKey = base_storage.PrivateKey.create()..value = key.value;
      storageKinAccount.privateKey = privateKey;
    }

    storageKinAccount.accounts.addAll(kinAccount.tokenAccounts.map((e) {
      return base_storage.PublicKey.create()..value = e.value;
    }));

    return storageKinAccount;
  }

  base_storage.KinBalance toStorageKinBalance(KinBalance kinBalance) {
    return base_storage.KinBalance.create()
      ..quarkAmount = fixnum.Int64(kinBalance.amount.toQuarks().value)
      ..pendingQuarkAmount =
          fixnum.Int64(kinBalance.pendingAmount.toQuarks().value);
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

    if (!file.parent.existsSync()) {
      file.parent.create(recursive: true);
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
  Future<List<InvoiceList>> addInvoiceLists(
      KinAccountId accountId, List<InvoiceList> invoiceLists) {
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
    // TODO: implement getAccount
    throw UnimplementedError();
  }

  @override
  List<KinAccountId> getAllAccountIds() {
    // TODO: implement getAllAccountIds
    throw UnimplementedError();
  }

  @override
  Future<Map<InvoiceListId, InvoiceList>> getInvoiceListsMapForAccountId(
      KinAccountId account) {
    // TODO: implement getInvoiceListsMapForAccountId
    throw UnimplementedError();
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
  Future<KinAccount> getStoredAccount(KinAccountId accountId) {
    // TODO: implement getStoredAccount
    throw UnimplementedError();
  }

  @override
  Future getStoredTransactions(KinAccountId accountId) {
    // TODO: implement getStoredTransactions
    throw UnimplementedError();
  }

  @override
  getTransactions(KinAccountId key) {
    // TODO: implement getTransactions
    throw UnimplementedError();
  }

  @override
  Future<List> insertNewTransactionInStorage(
      KinAccountId accountId, newTransaction) {
    // TODO: implement insertNewTransactionInStorage
    throw UnimplementedError();
  }

  @override
  void putTransactions(KinAccountId key, transactions) {
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
  Future<List> storeTransactions(KinAccountId accountId, List transactions) {
    // TODO: implement storeTransactions
    throw UnimplementedError();
  }

  @override
  bool updateAccount(KinAccount account) {
    // TODO: implement updateAccount
    throw UnimplementedError();
  }

  @override
  Future<KinAccount> updateAccountBalance(KinAccountId accountId, balance) {
    // TODO: implement updateAccountBalance
    throw UnimplementedError();
  }

  @override
  Future<KinAccount> updateAccountInStorage(KinAccount account) {
    // TODO: implement updateAccountInStorage
    throw UnimplementedError();
  }

  @override
  Future<List> upsertNewTransactionsInStorage(
      KinAccountId accountId, List newTransactions) {
    // TODO: implement upsertNewTransactionsInStorage
    throw UnimplementedError();
  }

  @override
  Future<List> upsertOldTransactionsInStorage(
      KinAccountId accountId, List oldTransactions) {
    // TODO: implement upsertOldTransactionsInStorage
    throw UnimplementedError();
  }
}
