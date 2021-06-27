import 'dart:ui';

import 'package:alert_dialog/alert_dialog.dart';
import 'package:backup_restore/backup_restore.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/storage/file_storage.dart';
import 'package:kin_base/kin.dart';
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

class BackupButton extends StatelessWidget {
  final Kin kin;

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

  KinBackupQRImage qrImage;

  void show(BuildContext context, String passphrase) {
    var accountId = kin.getKinContext().accountId;

    qrImage = KinBackupQRImage(passphrase, accountId: accountId);

    alert(
      context,
      title: Text('KIN Backup - QR Code'),
      content: GestureDetector(
        child: Container(
          width: 320,
          height: 320,
          child: qrImage,
        ),
        onTap: () async => _saveImage(context),
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

  void _saveImage(BuildContext context) async {
    var pngData =
        await qrImage.generateImageData(imageFormat: ImageByteFormat.png);

    var account = kin.getKinContext().accountId.stellarBase32Encode();

    var documentsDirectory = await getApplicationDocumentsDirectory();

    var dirPath = documentsDirectory.path;
    var fileName = 'kin-backup-$account.png';
    var fullPath = '$dirPath/$fileName';

    print('-- Saving PNG file: $fullPath > ${pngData.length} bytes...');
    var saved = FileStorage.create().writeToFile(dirPath, fileName, pngData);
    print('-- Saved: $saved > $fullPath');

    print('-- Saving to gallery...');
    var savedToGallery = await GallerySaver.saveImage(fullPath);
    print('-- Saved to gallery: $savedToGallery');

    if (saved && savedToGallery) {
      alert(
        context,
        title: Text('KIN Backup - QR Code'),
        content: Text('Image saved: $fileName'),
        textOK: Text('OK'),
      );
    } else {
      alert(
        context,
        title: Text('KIN Backup - QR Code'),
        content: Text('Error saving image: $fileName'),
        textOK: Text('OK'),
      );
    }
  }
}
