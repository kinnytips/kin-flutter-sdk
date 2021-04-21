import 'package:kin_base/base/models/kin_balance.dart';
import 'package:kin_base/stellarfork/operation.dart';
import 'package:meta/meta.dart';

import 'models/kin_account.dart';

class ObservationMode {
  ObservationMode(int value) {}


}

class Passive extends ObservationMode {
    Passive._() : super(0);
}

class Active extends ObservationMode {
    Active._() : super(1);
}

class ActiveNewOnly extends ObservationMode {
    ActiveNewOnly._() : super(2);
}

abstract class KinAccountReadOperationsAltIdioms {
  getAccount(Future<KinAccount> accountCallback, [bool forceUpdate = false]);

  Future<KinBalance> observeBalance(ValueListener<KinBalance> balanceListener, [ObservationMode = Passive]);

  clearStorage(Callback<bool> clearCompleteCallback);
}