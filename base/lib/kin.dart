import 'dart:typed_data';

import 'package:kin_base/base/models/app_info.dart';
import 'package:kin_base/base/models/appidx.dart';
import 'package:kin_base/base/network/services/app_info_providers.dart';
import 'package:kin_base/base/storage/kin_file_storage.dart';
import 'package:kin_base/base/tools/observers.dart';

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
  final void Function(KinBalance kinBalance) _onBalanceChange;
  final void Function(List<KinPayment> payments) _onPayment;
  final void Function(Kin kin) _onAccountContext;

  final DisposeBag _lifecycle;

  AppInfo _appInfo;

  KinEnvironmentAgora _environment;
  KinAccountContext _context;
  Observer<List<KinPayment>> _observerPayments;
  Observer<KinBalance> _observerBalance;

  final String storageLocation ;

  Kin(this._production,
      this._appIndex,
      this._appName,
      this._credentialUser,
      this._credentialPass,
      this._onBalanceChange,
      this._onPayment,
      this._onAccountContext,
      {this.storageLocation = "/tmp/kin-flutter"}) : _lifecycle = DisposeBag() {

    _setAppInfo();

    //fetch the account and set the context
    this._environment = this._getEnvironment();

    this._environment.allAccountIds().then((ids) {
      //First get (or create) an account id for this device
      String accountId =
          ids.isEmpty ? createAccount() : ids[0].stellarBase32Encode();

      //Then set the context with that single account
      this._context = this.getKinContext(accountId);
      _setAppInfo();

      if (_onAccountContext != null) {
        _onAccountContext(this);
      }

      //handle listeners
      if (this._onBalanceChange != null) {
        this._watchBalance(); //watch for changes in balance
      }

      if (this._onPayment != null) {
        this._watchPayments(); //watch for changes in payments
      }

      return null;
    });
  }

  void _setAppInfo() {
    var accountId = this?._context?.accountId ?? KinAccountId(Uint8List(32)) ;
    _appInfo = AppInfo(AppIdx(_appIndex), accountId, this._appName, 0);
  }

  String get address {
    return this._context.accountId.base58Encode();
  }

  void _watchPayments() {
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
    //watch for changes to this account
    _observerBalance = _context.observeBalance(mode: ObservationMode.Passive);

    _observerBalance.add((kinBalance) {
      if (_onBalanceChange != null) {
        _onBalanceChange(kinBalance);
      }
    });

    _observerBalance.disposedBy(_lifecycle);
  }

  KinAccountContext getKinContext(String accountId) {
    return new KinAccountContext.useExistingAccount(
        _environment, KinAccountId.fromIdString(accountId));
  }

  String createAccount() {
    var kinContext = KinAccountContext.newAccount(_environment);
    return kinContext.accountId.stellarBase32Encode();
  }

  KinEnvironmentAgora _getEnvironment() {
    NetworkEnvironment networkEnv = _production
        ? KinStellarMainNetKin3.instance
        : KinStellarTestNetKin3.instance;

    var appInfoProvider = AppInfoProviderSimple(_appInfo, _credentialUser, _credentialPass);

    var env = KinEnvironmentAgora.build(networkEnv, appInfoProvider: appInfoProvider,
    storageBuilder: ({NetworkEnvironment networkEnvironment}) => KinFileStorage(storageLocation, networkEnvironment));

    return env;
  }

/*

    private KinEnvironment.Agora getEnvironment() {
        String storageLoc = "/tmp/kin";

        NetworkEnvironment networkEnv = this.production ? NetworkEnvironment.KinStellarMainNetKin3.INSTANCE :
                NetworkEnvironment.KinStellarTestNetKin3.INSTANCE;

        return (new KinEnvironment.Agora.Builder(networkEnv))
                .setAppInfoProvider(new AppInfoProvider() {
                    @NotNull
                    private final AppInfo appInfo;

                    @NotNull
                    public AppInfo getAppInfo() {
                        return this.appInfo;
                    }

                    @NotNull
                    public AppUserCreds getPassthroughAppUserCredentials() {
                        return new AppUserCreds(
                                credentialsUser,
                                credentialsPass
                        );
                    }

                    {
                        this.appInfo = new AppInfo(
                                new AppIdx(appIndex),
                                new KinAccount.Id(appAddress),
                                "Example",
                                0
                        );
                    }
                })
                .setMinApiVersion(4) //make sure we're on the Agora chain (not the former stellar)
                .setStorage(new KinFileStorage.Builder(storageLoc))
                .build();
    }
     */

}
