import 'package:alert_dialog/alert_dialog.dart';
import 'package:backup_restore/backup_restore.dart';
import 'package:flutter/material.dart';
import 'package:kin_base/KinBackupRestore.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/kin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

class App extends StatefulWidget {
  final Kin kin;

  App({Key key, @required this.kin}) : super(key: key);

  @override
  _AppState createState() => _AppState(kin);
}

class _AppState extends State<App> {
  final Kin kin;

  _AppState(this.kin);

  KinAccountId accountId;

  String get accountIdStellarBase32 => accountId?.stellarBase32Encode() ?? '?';

  var homeNavigator = GlobalKey<NavigatorState>();

  @override
  void initState() {
    print('--- initState');
    print(kin);

    ensurePermissions().then((ok) {
      print('-- Permissions: $ok');

      kin.waitReady().then((ready) {
        print('-- KIN Ready: $ready ; $kin');

        setState(() {
          accountId = kin.getKinContext().accountId;
        });
      });

      print('-- KIN initialize');
      kin.initialize();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('-- Build: $context');

    var account =
        kin.isNotReady ? 'Loading...' : 'Account:\n$accountIdStellarBase32';

    print('-- account: $account');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kin SDK Demo'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                account,
                textAlign: TextAlign.center,
              ),
              onTap: (() => 1),
            ),
            BackupButton(kin),
          ],
        ),
      ),
    );
  }

  Future<bool> ensurePermissions() async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      status = await Permission.storage.request();
    }

    return status.isGranted;
  }
}

class BackupButton extends StatelessWidget {
  final Kin kin ;

  BackupButton(this.kin);

  @override
  Widget build(BuildContext context) => ListTile(
      title: Text(
        'Backup Wallet',
        style: TextStyle(
            color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 20),
        textAlign: TextAlign.center,
      ),
      onTap: () async => backupWallet(context),
    );

  void backupWallet(BuildContext context) async {
    String passphrase = await _promptPassword(context);
    print('-- Password: $passphrase');
    show(context, passphrase);
  }

  void show(BuildContext context, String passphrase) {
    var accountId = kin.getKinContext().accountId ;



    alert(
      context,
      title: Text('KIN Backup - QR Code'),
      content:
      Container(
        width: 320,
        height: 320,
        child: KinBackupQRImage(passphrase, accountId: accountId),
      ),
      textOK: Text('OK [I have saved this image]'),
    );
  }

  Future<String> _promptPassword(BuildContext context) async {
    var pass = await prompt(
      context,
      title: Text('KIN - Backup Password:'),
      initialValue: '',
      textOK: Text('OK'),
      textCancel: Text('Cancel'),
      hintText: 'Your backup password',
      minLines: 1,
      maxLines: 1,
      autoFocus: true,
      obscureText: false,
      obscuringCharacter: '•',
      textCapitalization: TextCapitalization.none,
    );
    return pass;
  }
}
