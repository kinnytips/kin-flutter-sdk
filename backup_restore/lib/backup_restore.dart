library backup_restore;

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:kin_base/KinBackupRestore.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/stellarfork/key_pair.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class _QrImage extends QrImage {
  static int defaultKeyCount = 0;

  final String jsonData;

  final Color backgroundColor;

  final Color foregroundColor;

  _QrImage(
      {String data,
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
      : jsonData = data,
        backgroundColor = backgroundColor,
        foregroundColor = foregroundColor,
        super(
          data: data,
          version: version,
          size: size,
          gapless: gapless,
          semanticsLabel: 'KIN QR code',
          key: LabeledGlobalKey('KinBackupQRImage:${++defaultKeyCount}'),
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

  @override
  LabeledGlobalKey get key => super.key as LabeledGlobalKey;

  final _MutableField<State<QrImage>> _lastState =
      _MutableField<State<QrImage>>();

  State<QrImage> get lastState => _lastState.value;

  @override
  createState() {
    return _lastState.value = super.createState();
  }
}

class _MutableField<T> {
  T value;
}

/// A KIN backup QR code image.
class KinBackupQRImage extends _QrImage {
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

  Future<Uint8List> generateImageData(
      {imageFormat: ui.ImageByteFormat.png}) async {
    ui.Image embeddedImage;
    if (this.embeddedImage != null) {
      embeddedImage = await _loadEmbeddedImage();
    }

    var size = this.size ??
        min(lastState.context.size.width, lastState.context.size.height);

    print(
        '- QrPainter: size: $size ; version: $version ; foregroundColor: $foregroundColor ; gapless: $gapless');

    var qrPainter = QrPainter(
        data: this.jsonData,
        version: version,
        color: foregroundColor,
        gapless: this.gapless,
        embeddedImage: embeddedImage,
        embeddedImageStyle: this.embeddedImageStyle,
        eyeStyle: this.eyeStyle);

    var data = await qrPainter.toImageData(size, format: imageFormat);

    return data?.buffer?.asUint8List();
  }

  Future<ui.Image> _loadEmbeddedImage() async {
    final completer = Completer<ui.Image>();

    final stream =
        this.embeddedImage.resolve(ImageConfiguration(devicePixelRatio: 1));

    ImageStreamListener streamListener;

    streamListener = ImageStreamListener((info, err) {
      stream.removeListener(streamListener);
      completer.complete(info.image);
    }, onError: (dynamic err, _) {
      stream.removeListener(streamListener);
      completer.completeError(err);
    });
    stream.addListener(streamListener);

    return completer.future;
  }
}
