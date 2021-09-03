import 'package:kin_base/KinBackupRestore.dart';
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

  var kin = Kin(
    production,
    appIndex,
    'Example App',
    onBalanceChange: _onBalanceChange,
    onPayment: _onPayment,
    onAccountContext: _onResolveAccountContext,
    credentialUser: credentialUser,
    credentialPass: credentialPass,
    createAccountIfEmpty: true,
  );

  await kin.waitReady();

  print('- Ready: $kin');

  print('- My Address: ${kin.addressAsBase58} > ${kin.addressAsStellarBase32}');

  var kinContext = kin.getKinContext();

  var account = await kinContext.getAccount(forceUpdate: true);
  print('- My Account: $account');
  print('- My Balance: ${account.balance}');

  showPaymentsForAccount(
      kin, 'GDNZ4TKB3FPM77ITEGG36O6EIKKXLH7ERAE4AUNBMXMEDUVS6VK5YZFQ');

  await sendKINToAccount(
      kin, '3RXbFoTTTHHKXu2MikKz8NWbGLnV5PfbcTaQR8Z7oxME', 0.10);

  print('** Generating Backup:');
  print('- AccountID: ${account.id.stellarBase32Encode()}');
  var secretSeed = account.id.toKeyPair().secretSeed;
  print('- SecretSeed: $secretSeed');

  var kinBackupRestore = KinBackupRestore();

  var backupPass = 'abc123';

  var accountBackup =
      kinBackupRestore.exportWallet(backupPass, account: account);

  print('- Backup JSON:');
  print(accountBackup.toJson());

  print('Recovering Backup:');
  var backupKeyPair = kinBackupRestore.importWallet(accountBackup, backupPass);
  print('- Recovered KeyPair: ${backupKeyPair.accountId}');
}

Future<KinPayment> sendKINToAccount(
    Kin kin, String destinationAccountID, double amount) async {
  var amountToSend = KinAmount.fromDouble(amount);
  var destinationAccount = KinAccountId.fromIdString(destinationAccountID);

  print('destinationAccount: $destinationAccount');
  print('amountToSend: $amountToSend');

  var kinContext = kin.getKinContext();
  var sentPayment =
      await kinContext.sendKinPayment(amountToSend, destinationAccount);

  print('SENT> $sentPayment');

  return sentPayment;
}

void showPaymentsForAccount(Kin kin, String accountID) {
  print('** Getting payments for account: $accountID ...');

  var kinContext2 = kin.getKinContext(accountID);

  var observePayments = kinContext2.observePayments();

  observePayments.add((payments) {
    for (var i = 0; i < payments.length; ++i) {
      var p = payments[i];
      print('[$i]> $p');
    }
  });
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
