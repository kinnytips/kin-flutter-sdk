import 'dart:convert';
import 'dart:typed_data';

import 'package:kin_base/base/tools/extensions.dart';

class SHA224Hash {
  final String encodedValue;

  SHA224Hash(this.encodedValue);

  SHA224Hash.fromBytes(Uint8List bytes) : this(base64.encode(bytes));

  factory SHA224Hash.of(Uint8List bytes) =>
      SHA224Hash.fromBytes(bytes.toSha224());

  factory SHA224Hash.just(Uint8List bytes) => SHA224Hash.fromBytes(bytes);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SHA224Hash &&
          runtimeType == other.runtimeType &&
          encodedValue == other.encodedValue;

  @override
  int get hashCode => encodedValue.hashCode;

  @override
  String toString() {
    return 'SHA224Hash{$encodedValue}';
  }
}
