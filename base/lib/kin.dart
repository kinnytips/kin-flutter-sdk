import 'dart:async';

import 'package:kin_base/models/app/account/create_kin_account_response.dart';
import 'package:kin_base/models/app/account/retrieve_kin_account_response.dart';
import 'package:kin_base/models/app/exceptions/account_id_not_set_exception.dart';
import 'package:kin_base/models/app/interfaces/status.dart';
import 'package:kin_base/models/app/transaction/submit_kin_transaction_response.dart';
import 'package:kin_base/models/app/transaction/transaction_history_response.dart';
import 'package:kin_base/services/kin_services.dart';
import 'package:logging/logging.dart';

import 'package:kin_base/base/tools/observers.dart';

import 'base/kin_account_context.dart';
import 'base/kin_environment.dart';
import 'base/models/kin_balance.dart';
import 'base/models/kin_payment.dart';
import 'base/stellar/models/network_environment.dart';
import 'base/tools/observers.dart';
import 'models/agora/protobuf/account/v4/account_service.pbenum.dart';

/// KinSDK allows the user to interact with the Kin blockchain
/// SDK can be instantiated either in production mode or development mode
/// When in production mode only `severe` errors are logged
/// In development mode all levels of logging is available
/// Environment must be indicated either eith `true` or with `false` while instantiating the instance.
/// SDK can also be instantiated by setting an `accountId`
class Kin {

  final bool _production;
  final int _appIndex;
  final String _appAddress;
  final String _credentialsUser;
  final String _credentialsPass;
  final void Function(KinBalance kinBalance) _onBalanceChange;
  final void Function(List<KinPayment> payments) _onPayment;
  final void Function(Kin kin) _onAccountContext;

  final DisposeBag _lifecycle;

  KinEnvironmentAgora _environment;
  KinAccountContext _context;
  Observer<List<KinPayment>> _observerPayments;
  Observer<KinBalance> _observerBalance;

   Kin(
            this._production,
  this._appIndex,
  this._appAddress,
  this._credentialsUser,
  this._credentialsPass,
  this._onBalanceChange,
       this._onPayment,
       this._onAccountContext
    ) : _lifecycle = DisposeBag() {


        //fetch the account and set the context
        this._environment = this.getEnvironment();

        this._environment.allAccountIds().then(it -> {
            //First get (or create) an account id for this device
            String accountId = it.size() == 0 ? createAccount() : ((KinAccountId) it.get(0)).stellarBase32Encode();

            //Then set the context with that single account
            this.context = this.getKinContext(accountId);

            if (onAccountContext != null) {
                onAccountContext.invoke(this);
            }

            return null;
        });

        //handle listeners
        if (this._balanceChanged != null) {
            this._watchBalance(); //watch for changes in balance
        }

        if (this._paymentHappened != null) {
            this._watchPayments(); //watch for changes in payments
        }
    }

  KinEnvironmentAgora _getEnvironment() {
    String storageLoc = "/tmp/kin";

    NetworkEnvironment networkEnv = _production ? KinStellarMainNetKin3.instance : KinStellarTestNetKin3.instance;

    KinEnvironmentAgora();

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
