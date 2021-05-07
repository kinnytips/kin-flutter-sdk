import 'dart:typed_data';

import 'package:crypto/crypto.dart' show sha256 ;

import 'package:fast_base58/fast_base58.dart' as fast_base58 ;

import 'package:collection/collection.dart' show ListEquality;

class Base58 {

  String encode(Uint8List input) => fast_base58.Base58Encode(input);

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
      return "Version not in range 0>..<255: $version";
    }
  }

  Uint8List decode(String input) => fast_base58.Base58Decode(input);

  BigInt decodeToBigInteger(String input) {
    return BigInt.parse(input);
  }

  Uint8List decodeChecked(String input){
    var decoded = decode(input);
    if (decoded.length < 4) throw InvalidDataLength("Input too short: " + decoded.length.toString());
    var data = Uint8List.view(decoded.buffer, 0, decoded.length - 4);
    var checksum = Uint8List.view(decoded.buffer, decoded.length - 4, decoded.length);
    Uint8List actualChecksum = Uint8List.view(hashTwice(data).buffer, 0, 4);
    if ( !ListEquality<int>().equals(checksum, actualChecksum) ) {
      throw InvalidChecksum();
    }
    return data;
  }

  Uint8List hashTwice(Uint8List input, [int offset = 0, int length]) {
    if ( ( offset != null && offset > 0 ) || (length != null) ) {
      input = input.sublist(offset, offset + length);
    }

    var hash1 = sha256.convert(input);
    var hash2 = sha256.convert(hash1.bytes);
    return Uint8List.fromList(hash2.bytes );
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