import 'dart:ui';

import 'package:alert_dialog/alert_dialog.dart';
import 'package:backup_restore/backup_restore.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/storage/file_storage.dart';
import 'package:kin_base/kin.dart';
import 'package:kin_sdk_example_flutter/widget/backup/backup_button.dart';
import 'package:path_provider/path_provider.dart';
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

    var accountText =
        kin.isNotReady ? 'Loading...' : 'Account:\n$accountIdStellarBase32';

    print('-- account: $accountText');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kin SDK Demo'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                accountText,
                textAlign: TextAlign.center,
              ),
              onTap: (() => 1),
            ),
            if (kin.isReady) BackupButton(kin),
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
