import 'dart:convert';
import 'dart:typed_data';

import 'package:kinny/base/tools/extensions.dart';

class SHA224Hash {
  final String encodedValue;

  SHA224Hash(this.encodedValue);

  SHA224Hash.fromBytes(Uint8List bytes) : this(base64.encode(bytes));

  factory SHA224Hash.of(Uint8List bytes) =>
      SHA224Hash.fromBytes(bytes.toSha224());

  factory SHA224Hash.just(Uint8List bytes) => SHA224Hash.fromBytes(bytes);
}
