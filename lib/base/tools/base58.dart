import 'dart:typed_data';

import 'package:flutter/services.dart';

class Base58 {
  static final List<String> ALPHABET = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".split('');
  final String ENCODED_ZERO = ALPHABET[0];
  final INDEXES = new List<int>();

  String encode(Uint8List input) {
    var inputCopy = input;
    if(inputCopy.lengthInBytes == 0) return "";
    var zeros = 0;
    while (zeros < inputCopy.lengthInBytes && inputCopy[zeros] == Uint8List.fromList([0]).single) {
        zeros++;
    }

    inputCopy = Uint8List.view(inputCopy.buffer, inputCopy.offsetInBytes, inputCopy.length);
    var encoded = new List<String>(inputCopy.length * 2);
    var outputStart = encoded.length;
    var inputStart = zeros;
    while (inputStart < inputCopy.length) {
      encoded[outputStart--] = ALPHABET[divmod(inputCopy, inputStart, 256, 58).to<int>()];
      if(inputCopy[inputStart] == Uint8List.fromList([0]).single) {
        inputStart++;
      }
    }

    while (outputStart < encoded.length && encoded[outputStart] == ENCODED_ZERO) {
        outputStart++;
    }

    while(zeros-- >= 0) {
      encoded[outputStart--] = ENCODED_ZERO;
    }

    return String(encoded, outputStart, encoded.length - outputStart);
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