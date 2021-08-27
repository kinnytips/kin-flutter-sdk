//
// Based into:
// `dart-hex` (https://github.com/stevenroose/dart-hex) [The MIT License (MIT)]
//

import "dart:convert";
import "dart:typed_data";

const String _ALPHABET = '0123456789abcdef';

/// An instance of the default implementation of the [HexCodec].
const HEX = const HexCodec();

/// A codec for encoding and decoding byte arrays to and from
/// hexadecimal strings.
class HexCodec extends Codec<List<int>, String?> {
  const HexCodec();

  @override
  Converter<List<int>, String> get encoder => const HexEncoder();

  @override
  Converter<String, Uint8List> get decoder => const HexDecoder();
}

/// A converter to encode byte arrays into hexadecimal strings.
class HexEncoder extends Converter<List<int>, String> {
  /// If true, the encoder will encode into uppercase hexadecimal strings.
  final bool upperCase;

  const HexEncoder({this.upperCase: false});

  @override
  String convert(List<int> bytes) {
    var buffer = new StringBuffer();
    for (int part in bytes) {
      if (part & 0xff != part) {
        throw new FormatException('Non-byte integer detected');
      }

      var h = part.toRadixString(16).padLeft(2, '0');
      buffer.write(h);
    }

    if (upperCase) {
      return buffer.toString().toUpperCase();
    } else {
      return buffer.toString();
    }
  }
}

/// A converter to decode hexadecimal strings into byte arrays.
class HexDecoder extends Converter<String, Uint8List> {
  const HexDecoder();

  static final _regexpBlankSpace = RegExp(r'\s+');

  @override
  Uint8List convert(String hex) {
    var str = hex.replaceAll(_regexpBlankSpace, '');
    str = str.toLowerCase();

    var strLength = str.length;
    if (strLength % 2 != 0) {
      str = '0$str';
    }

    var result = Uint8List(strLength ~/ 2);
    var resultSize = 0 ;

    for (var i = 1; i < strLength; i += 2) {
      var h0 = str[i - 1];
      var h1 = str[i];

      var firstDigit = _ALPHABET.indexOf(h0);
      var secondDigit = _ALPHABET.indexOf(h1);
      if (firstDigit == -1 || secondDigit == -1) {
        throw new FormatException("Non-hex character detected in $hex");
      }

      result[resultSize++] = (firstDigit << 4) + secondDigit;
    }

    return result;
  }
}
