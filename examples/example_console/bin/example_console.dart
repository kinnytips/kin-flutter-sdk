import 'package:kin_base/base/models/kin_balance.dart';
import 'package:kin_base/base/models/kin_payment.dart';
import 'package:kin_base/kin.dart';

void main(List<String> arguments) async {
  var production = true;
  var appIndex = 0;

  var credentialUser = 'credentialUser';
  var credentialPass = 'credentialPass';

  var kin = Kin(production, appIndex, 'Example App', credentialUser,
      credentialPass, _onBalanceChange, _onPayment, _onResolveAccountContext);

  print(kin);
}

void _onBalanceChange(KinBalance balance) {
  print('[Balance Change] $balance');
}

void _onPayment(List<KinPayment> payments) {
  print('[Payments] $payments > $payments');
}

void _onResolveAccountContext(Kin kin) {
  print('[Account Context] $kin : address: ${kin.address}');
}
