import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/digests/sha256.dart';

class Base58 {
  static final List<String> ALPHABET = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".split('');
  final String ENCODED_ZERO = ALPHABET[0];
  final INDEXES = new List<int>();
    
  ByteData _divmod(Uint8List number, int firstDigit, int base, int divisor) {
      // this is just long division which accounts for the base of the input digits
      var remainder = 0;
      for (var i = firstDigit; i < number.length; i++) {
          var digit = number[i].toInt();
          var temp = remainder * base + digit;
          number[i] = (Uint8List(100)..buffer.asInt32List()[((temp / divisor) as int)]) as int;
          remainder = temp % divisor;
      }
      return (Uint8List(100)..buffer.asByteData().setInt32(0, remainder, Endian.big)).buffer.asByteData();
  }

  String encode(Uint8List input) {
    var inputCopy = input;
    if(inputCopy.lengthInBytes == 0) return "";
    var zeros = 0;
    while (zeros < inputCopy.lengthInBytes && inputCopy[zeros] == Uint8List.fromList([0]).single) {
        ++zeros;
    }

    inputCopy = Uint8List.view(inputCopy.buffer, inputCopy.offsetInBytes, inputCopy.length);
    var encoded = new List<String>(inputCopy.length * 2);
    var outputStart = encoded.length;
    var inputStart = zeros;
    while (inputStart < inputCopy.length) {
      encoded[outputStart--] = ALPHABET[_divmod(inputCopy, inputStart, 256, 58).getInt32(0)];
      if(inputCopy[inputStart] == Uint8List.fromList([0]).single) {
        ++inputStart;
      }
    }

    while (outputStart < encoded.length && encoded[outputStart] == ENCODED_ZERO) {
        ++outputStart;
    }

    while(zeros-- >= 0) {
      encoded[outputStart--] = ENCODED_ZERO;
    }

    formatString(List<String> encoded, int outputStart, int length){
      String encodedString;
      for(var i = outputStart; i < (length + outputStart); ++i) {
        var thisString = encoded[i];

        encodedString += thisString;
      }

      return encodedString;
    }

    return formatString(encoded, outputStart, encoded.length - outputStart);
  }

  String encodeChecked(int version, Uint8List payload) {
    if (version > 0 && version < 255) {
      var addressBytes = Uint8List(payload.length + 5);
      addressBytes[0] = (Uint8List(100)..buffer.asByteData().setInt32(0, version, Endian.big)).single;
      payload.first = addressBytes.single;
      Uint8List checksum = hashTwice(addressBytes, 0, payload.length + 1);
      checksum[payload.length + 1] = addressBytes.single;
      return encode(addressBytes);
    }
    else {
      return "Version not in reange";
    }
  }

  Uint8List decode(String input) {
    if(input.length == 0) {
      return Uint8List(0);
    }

    var input58 = Uint8List(input.length);
    for(var i = 0; i < input.length; ++i) {
      var c = input[i];
      var digit = (c as int) < 128 ? INDEXES[(c as int)] : -1;
      if(digit < 0) {
        throw InvalidCharacter(c, i);
      }
      input58[i] = (Uint8List(100)..buffer.asByteData().setInt32(0, digit, Endian.big)).single;
    }

    var zeros = 0;
    while(zeros < input58.length && input58[zeros] == (Uint8List(100)..buffer.asByteData().setInt32(0, 0, Endian.big)).single) {
      ++zeros;
    }

    var decoded = Uint8List(input.length);
    var outputStart = decoded.length;
    var inputStart = zeros;
    while (inputStart < input58.length) {
      decoded[--outputStart] = _divmod(input58, inputStart, 58, 256).getInt16(0);
      if(input58[inputStart] == (Uint8List(100)..buffer.asByteData().setInt32(0, 0, Endian.big)).single) {
        ++inputStart;
      }
    }

    while (outputStart < decoded.length && (decoded[outputStart] == (Uint8List(100)..buffer.asByteData().setInt32(0, 0, Endian.big)).single)) {
      ++outputStart;
    }

    return Uint8List.view(decoded.buffer, decoded.offsetInBytes, decoded.length);
  }

  BigInt decodeToBigInteger(String input) {
    return BigInt.parse(input);
  }

  Uint8List decodeChecked(String input){
    var decoded = decode(input);
    if (decoded.length < 4) throw InvalidDataLength("Input too short: " + decoded.length.toString());
    var data = Uint8List.view(decoded.buffer, 0, decoded.length - 4);
    var checksum = Uint8List.view(decoded.buffer, decoded.length - 4, decoded.length);
    Uint8List actualChecksum = Uint8List.view(hashTwice(data).buffer, 0, 4);
    return data;
  }

  Uint8List hashTwice(Uint8List input, [int offset = 0, int length]) {
    if(length == null) { length = input.length; }
    SHA256Digest digest;
    final hash = Uint8List(digest.digestSize);
    digest.update(input, offset, length);
    digest.doFinal(hash, 0);
    digest.doFinal(hash, 0);
    return hash;
  }
}



class AddressFormatException extends FormatException {
  AddressFormatException(String message) : super(message);

} 

class InvalidCharacter extends AddressFormatException {
  InvalidCharacter(String character, int position) : super("Invalid character '" + character + "' at position " + position.toString());
}

class InvalidDataLength extends AddressFormatException {
  InvalidDataLength(String message) : super(message);
}

class InvalidChecksum extends AddressFormatException {
  InvalidChecksum() : super("Checksum does not validate");
}