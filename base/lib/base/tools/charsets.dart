import 'dart:convert' as _convert;
import 'dart:typed_data';

import 'package:kinny/base/tools/extensions.dart';

class Charset {
  static final Charset utf8 = Charset('utf8');
  static final Charset latin1 = Charset('latin1');
  static final Charset iso8859_1 = latin1;

  final String name;

  Charset(String name)
      : name = name.toLowerCase().trim().replaceAll(RegExp(r'\W'), '');

  _convert.Encoding get codec {
    switch (name) {
      case 'utf8':
        return _convert.utf8;
      case 'latin1':
        return _convert.latin1;
      case 'iso88591':
        return _convert.latin1;
      default:
        throw StateError("No Charset codec for: $name");
    }
  }

  Uint8List encode(String s) {
    var encoded = codec.encode(s);
    return Uint8ListExtension.asUint8List(encoded);
  }

  String decode(Uint8List bytes) {
    var decoded = codec.decode(bytes);
    return decoded;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Charset &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
