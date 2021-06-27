import 'dart:ui';

import 'package:alert_dialog/alert_dialog.dart';
import 'package:backup_restore/backup_restore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:kin_base/base/storage/file_storage.dart';
import 'package:kin_base/kin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

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