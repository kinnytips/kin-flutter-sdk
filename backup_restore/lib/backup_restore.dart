library backup_restore;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kin_base/KinBackupRestore.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/stellarfork/key_pair.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// A KIN backup QR code image.
class KinBackupQRImage extends QrImage {
  /// Generates KIN backup the JSON data used by the QR code.
  static String generateBackupJson(String passphrase,
      {KeyPair keyPair, KinAccountId accountId, KinAccount account}) {
    var backupRestore = KinBackupRestore();
    var accountBackup = backupRestore.exportWallet(passphrase,
        keyPair: keyPair, accountId: accountId, account: account);
    return accountBackup.toJson();
  }

  /// Constructs a KIN backup QR code image.
  ///
  /// - [passphrase] the password of the backup data.
  /// - [keyPair] or [account] to backup.
  /// - Other parameters are the same of [QrImage].
  KinBackupQRImage(String passphrase,
      {KeyPair keyPair,
      KinAccountId accountId,
      KinAccount account,
      Key key,
      double size,
      EdgeInsets padding = const EdgeInsets.all(10.0),
      Color backgroundColor = Colors.transparent,
      Color foregroundColor,
      int version = QrVersions.auto,
      int errorCorrectionLevel = QrErrorCorrectLevel.L,
      QrErrorBuilder errorStateBuilder,
      bool constrainErrorBounds = true,
      bool gapless = true,
      ImageProvider<Object> embeddedImage,
      QrEmbeddedImageStyle embeddedImageStyle,
      QrEyeStyle eyeStyle =
          const QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.black),
      QrDataModuleStyle dataModuleStyle = const QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square, color: Colors.black),
      bool embeddedImageEmitsError = false})
      : super(
          data: generateBackupJson(passphrase,
              keyPair: keyPair, accountId: accountId, account: account),
          version: version,
          size: size,
          gapless: gapless,
          semanticsLabel: 'KIN QR code',
          key: key,
          padding: padding,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          errorCorrectionLevel: errorCorrectionLevel,
          errorStateBuilder: errorStateBuilder,
          constrainErrorBounds: constrainErrorBounds,
          embeddedImage: embeddedImage,
          embeddedImageStyle: embeddedImageStyle,
          eyeStyle: eyeStyle,
          dataModuleStyle: dataModuleStyle,
          embeddedImageEmitsError: embeddedImageEmitsError,
        );
}
