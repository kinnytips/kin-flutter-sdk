import 'dart:io';

import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_amount.dart';
import 'package:kin_base/base/models/kin_payment.dart';
import 'package:kin_base/kin.dart';

void main(List<String> args) async {
  String? walletBackupJsonFile;
  String? walletBackupPassword;
  String? walletBackupJson;

  if (args.length >= 2) {
    walletBackupJsonFile = args[0];
    walletBackupPassword = args[1];
    walletBackupJson = File(walletBackupJsonFile).readAsStringSync();
    print('Loaded backup JSON file: $walletBackupJsonFile');
    print(walletBackupJson);
  }

  var production = true;
  var appIndex = 0;

  var kin = Kin(
    production,
    appIndex,
    'Example App',
    storageLocation:
        '/tmp/kin-flutter-example-${DateTime.now().millisecondsSinceEpoch}',
  );

  print(kin);

  print('KIN storage location: ${kin.storageLocation}');

  var allAccountIds = await kin.allAccountIds();

  print('Local accounts:');
  print(allAccountIds.map((e) => e.base58Encode()).toList());

  KinAccountId accountId;

  if (walletBackupJson != null) {
    accountId = await kin.importWallet(walletBackupJson, walletBackupPassword!);
    print('Imported wallet account: $accountId');
  } else if (allAccountIds.isNotEmpty) {
    var loadedAccountId = await kin.loadLocalAccount();
    print('Loaded local account: $loadedAccountId');
    if (loadedAccountId == null) {
      throw StateError("Can't load local account!");
    }
    accountId = loadedAccountId;
  } else {
    print('Creating Account/Wallet:');
    accountId = kin.createAccount();
    print('Created account: $accountId');
  }

  kin.setContextByAccountID(accountId);

  var account = await kin.getKinContext()!.getAccount();

  print('Current context account: $account');
  print('Current context balance: ${account?.balance}');

  var sentPayment = await submitTransaction(
      kin, '3RXbFoTTTHHKXu2MikKz8NWbGLnV5PfbcTaQR8Z7oxME', 0.10);

  if (sentPayment != null) {
    showPaymentsForAccount(kin, accountId.base58Encode());
  }

  var backupJson = kin.backupWallet('123456', accountId: accountId);

  print('Backup JSON:');
  print(backupJson);

  await Future.delayed(Duration(seconds: 60));
}

Future<KinPayment?> submitTransaction(
    Kin kin, String destinationAccountID, double amount) async {
  if (kin.isNotReady) {
    print("Can't send payments without a defined contexts at: $kin");
    return null;
  }

  var amountToSend = KinAmount.fromDouble(amount);
  var destinationAccount = KinAccountId.fromIdString(destinationAccountID);

  print('Destination Account: $destinationAccount');
  print('Amount to send: $amountToSend');

  var kinContext = kin.getKinContext()!;
  var sentPayment =
      await kinContext.sendKinPayment(amountToSend, destinationAccount);

  print('Sent payment: $sentPayment');

  return sentPayment;
}

void showPaymentsForAccount(Kin kin, String accountID) {
  print('** Getting payments for account: $accountID ...');

  var kinContext2 = kin.getKinContext(accountID)!;

  var observePayments = kinContext2.observePayments();

  observePayments.add((payments) {
    for (var i = 0; i < payments.length; ++i) {
      var p = payments[i];
      print('[$i]> $p');
    }
  });
}
