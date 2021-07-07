import 'dart:async';
import 'dart:typed_data';

import 'package:kin_base/KinBackupRestore.dart';
import 'package:kin_base/base/models/app_info.dart';
import 'package:kin_base/base/models/appidx.dart';
import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/network/services/app_info_providers.dart';
import 'package:kin_base/base/storage/kin_file_storage.dart';
import 'package:kin_base/base/tools/observers.dart';
import 'package:kin_base/stellarfork/key_pair.dart';

import 'base/kin_account_context.dart';
import 'base/kin_environment.dart';
import 'base/models/kin_account.dart';
import 'base/models/kin_balance.dart';
import 'base/models/kin_payment.dart';
import 'base/stellar/models/network_environment.dart';
import 'base/tools/observers.dart';

/// KinSDK allows the user to interact with the Kin blockchain
/// SDK can be instantiated either in production mode or development mode
/// When in production mode only `severe` errors are logged
/// In development mode all levels of logging is available
/// Environment must be indicated either eith `true` or with `false` while instantiating the instance.
/// SDK can also be instantiated by setting an `accountId`
class Kin {
  final bool _production;
  final int _appIndex;
  final String _appName;
  final String _credentialUser;
  final String _credentialPass;

  void Function(KinBalance kinBalance) _onBalanceChange;
  void Function(List<KinPayment> payments) _onPayment;
  void Function(Kin kin) _onAccountContext;

  final DisposeBag _lifecycle;

  AppInfo _appInfo;

  KinEnvironmentAgora _environment;
  KinAccountContext _context;
  Observer<List<KinPayment>> _observerPayments;
  Observer<KinBalance> _observerBalance;

  final String storageLocation;

  Kin(
    this._production,
    this._appIndex,
    this._appName, {
    this.storageLocation = "/tmp/kin-flutter",
    void Function(KinBalance kinBalance) onBalanceChange,
    void Function(List<KinPayment> payments) onPayment,
    void Function(Kin kin) onAccountContext,
    String credentialUser,
    String credentialPass,
    bool initialize = true
  })  : _onBalanceChange = onBalanceChange,
        _onPayment = onPayment,
        _onAccountContext = onAccountContext,
        _credentialUser = credentialUser,
        _credentialPass = credentialPass,
        _lifecycle = DisposeBag() {
    _setAppInfo();

    this._environment = this._getEnvironment();

    if (initialize) {
      this.loadLocalAccount();
    }
  }

  Future<KinAccountId> loadLocalAccount({bool createAccountIfEmpty = false}) async {
    // Fetch  accounts and set the context:
    var ids = await this._environment.allAccountIds();

    KinAccountId accountId ;

    if (ids.isEmpty) {
      if (createAccountIfEmpty) {
        accountId = createAccount();
      }
      else {
        return null ;
      }
    }
    else {
      accountId = ids[0];
    }

    setContextByAccountID(accountId);

    return accountId;
  }

  void setContextByAccountID(dynamic accountId) {
    this._context = this.getKinContext( KinAccountId.from(accountId) );
    _setAppInfo();

    if (_onAccountContext != null) {
      _onAccountContext(this);
    }

    _notifyReady();
  }

  Function get onBalanceChange => _onBalanceChange;

  set onBalanceChange(Function value) {
    if (identical(_onBalanceChange, value)) return;

    _onBalanceChange = value;

    if (isReady && _onBalanceChange != null) {
      this._watchBalance();
    }
  }

  Function get onPayment => _onPayment;

  set onPayment(Function value) {
    if (identical(_onPayment, value)) return;

    _onPayment = value;

    if (isReady && _onPayment != null) {
      this._watchPayments();
    }
  }

  Function get onAccountContext => _onAccountContext;

  set onAccountContext(Function value) {
    if (identical(_onAccountContext, value)) return;

    _onAccountContext = value;

    if (_context != null) {
      _onAccountContext(this);
    }
  }

  final Completer<bool> _waitReady = Completer<bool>();

  bool get isReady => _waitReady.isCompleted;

  bool get isNotReady => !isReady;

  void _notifyReady() {
    if (_waitReady.isCompleted) return;
    _waitReady.complete(true);

    if (this._onBalanceChange != null) {
      this._watchBalance();
    }

    if (this._onPayment != null) {
      this._watchPayments();
    }
  }

  Future<bool> waitReady() => _waitReady.future;

  void _setAppInfo() {
    var accountId = this?._context?.accountId ?? KinAccountId(Uint8List(32));
    _appInfo = AppInfo(AppIdx(_appIndex), accountId, this._appName, 0);
  }

  String get address {
    return this._context.accountId.base58Encode();
  }

  String get addressAsStellarBase32 {
    return this._context.accountId.stellarBase32Encode();
  }

  String get addressAsBase58 {
    return this._context.accountId.base58Encode();
  }

  void _watchPayments() {
    if (_observerPayments != null || _onPayment == null) return;

    //watch for changes to this account
    _observerPayments = _context.observePayments(mode: ObservationMode.Passive);

    _observerPayments.add((payments) {
      if (_onPayment != null) {
        _onPayment(payments);
      }
    });

    _observerPayments.disposedBy(_lifecycle);
  }

  void _watchBalance() {
    if (_observerBalance != null || _onBalanceChange == null) return;

    //watch for changes to this account
    _observerBalance = _context.observeBalance(mode: ObservationMode.Passive);

    _observerBalance.add((kinBalance) {
      if (_onBalanceChange != null) {
        _onBalanceChange(kinBalance);
      }
    });

    _observerBalance.disposedBy(_lifecycle);
  }

  KinAccountContext getKinContext([dynamic accountId]) {
    if (accountId == null) {
      return _context;
    }

    return new KinAccountContext.useExistingAccount(
        _environment, KinAccountId.from(accountId));
  }

  Future<List<KinAccountId>> allAccountIds() => this._environment.allAccountIds();

  KinAccountId createAccount() {
    var kinContext = KinAccountContext.newAccount(_environment);
    return kinContext.accountId ;
  }

  KinEnvironmentAgora _getEnvironment() {
    NetworkEnvironment networkEnv = _production
        ? KinStellarMainNetKin3.instance
        : KinStellarTestNetKin3.instance;

    var appInfoProvider =
        AppInfoProviderSimple(_appInfo, _credentialUser, _credentialPass);

    var env = KinEnvironmentAgora.build(networkEnv,
        appInfoProvider: appInfoProvider,
        storageBuilder: ({NetworkEnvironment networkEnvironment}) =>
            KinFileStorage(storageLocation, networkEnvironment));

    return env;
  }

  Future<KinAccountId> importWallet(String backupJson, String backupPassword) async {
    var kinBackupRestore = KinBackupRestore();
    var keyPair = kinBackupRestore.importWallet(backupJson, backupPassword);

    var account = KinAccount(PrivateKey.fromBytes(keyPair.privateKey));

    return importAccount(account);
  }

  Future<KinAccountId> importAccount(KinAccount account, {bool overwriteStoredAccount = false}) async {
    var accountId = account.id;

    var storedAccount = _environment.storage.getAccount(accountId);
    if ( storedAccount != null && !overwriteStoredAccount) {
      return storedAccount.id ;
    }

    _environment.storage.addAccount(account);

    var kinContext = getKinContext(accountId) as KinAccountContextBase ;

    var accountUpdated = await kinContext.getAccountUpdated() ;

    return accountUpdated.id ;
  }

  String backupWallet(String backupPassword,
      {KeyPair keyPair, KinAccountId accountId, KinAccount account}) {
    var kinBackupRestore = KinBackupRestore();

    var backup = kinBackupRestore.exportWallet(backupPassword,
        keyPair: keyPair, accountId: accountId, account: account);

    return backup.toJson();
  }

  @override
  String toString() {
    var accountId = _context?.accountId;
    var stellarBase32 = accountId?.stellarBase32Encode();
    var base58 = accountId?.base58Encode();
    return 'Kin{_production: $_production, _appIndex: $_appIndex, _appName: $_appName, _credentialUser: $_credentialUser, _appInfo: $_appInfo, storageLocation: $storageLocation, accountId: $stellarBase32 ($base58)}';
  }
}
