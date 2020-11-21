import 'dart:convert';
import 'dart:typed_data';

enum EncodingType { utf8, utf16 }

abstract class StringUtils {
  static Uint8List getBytesUnchecked(String string) {
    if (string == null) return null;
    try {
      return getBytesUnchecked(string);
    } catch (e) {
      /// todo need to catch specific exception
      ///
      throw Exception(e);
    }
  }

  static Uint8List getBytesUtf8(String string) {
    return Utf8Encoder().convert(string);
  }

  static String newStringUtf8(Uint8List bytes) {
    return Utf8Codec().decode(bytes);
  }
}
