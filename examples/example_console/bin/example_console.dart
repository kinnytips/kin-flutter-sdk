import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_amount.dart';
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

  await kin.waitReady();

  print('Ready: $kin');

  print('My Address: ${ kin.addressAsBase58 } > ${ kin.addressAsStellarBase32 }') ;

  var kinContext = kin.getKinContext();

  var account = await kinContext.getAccount(forceUpdate: true) ;
  print('Account: $account');
  print('Balance: ${ account.balance }');


  var amountToSend = KinAmount.fromInt(1);
  var destinationAccount = KinAccountId.fromIdString('3RXbFoTTTHHKXu2MikKz8NWbGLnV5PfbcTaQR8Z7oxME');

  print('amountToSend: $amountToSend');
  print('destinationAccount: $destinationAccount');

  var sentPayment = await kinContext.sendKinPayment(amountToSend, destinationAccount) ;

  print(sentPayment);
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
