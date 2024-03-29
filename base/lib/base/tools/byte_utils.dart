

import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:kin_base/base/tools/hex.dart';

import 'extensions.dart';

extension Uint8ListExtension on Uint8List {

  Uint8List toSha256() => sha256.convert(this).toUint8List();

  String toHex() => HexCodec().encoder.convert(this);

}
