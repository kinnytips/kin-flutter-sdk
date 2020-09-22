import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:fixnum/fixnum.dart' as fixNum;
import 'package:tweetnacl/tweetnacl.dart' as ed25519;

import "../util.dart";

class VersionByte {
  final _value;

  const VersionByte._internal(this._value);

  toString() => 'VersionByte.$_value';

  VersionByte(this._value);

  getValue() => this._value;

  static const ACCOUNT_ID = const VersionByte._internal((6 << 3)); // G
}

class StrKey {
  static String encodeStellarAccountId(Uint8List data) {
    return encodeCheck(VersionByte.ACCOUNT_ID, data);
  }

  static Uint8List decodeStellarAccountId(String data) {
    return decodeCheck(VersionByte.ACCOUNT_ID, data);
  }

  static String encodeCheck(VersionByte versionByte, Uint8List data) {
    List<int> output = List();
    output.add(versionByte.getValue());
    output.addAll(data);

    Uint8List payload = Uint8List.fromList(output);
    Uint8List checksum = StrKey.calculateChecksum(payload);
    output.addAll(checksum);
    Uint8List unencoded = Uint8List.fromList(output);

    String charsEncoded = Base32.encode(unencoded);

    return charsEncoded;
  }

  static Uint8List decodeCheck(VersionByte versionByte, String encData) {
    Uint8List decoded = Base32.decode(encData);
    int decodedVersionByte = decoded[0];
    Uint8List payload =
        Uint8List.fromList(decoded.getRange(0, decoded.length - 2).toList());
    Uint8List data =
        Uint8List.fromList(payload.getRange(1, payload.length).toList());
    Uint8List checksum = Uint8List.fromList(
        decoded.getRange(decoded.length - 2, decoded.length).toList());

    if (decodedVersionByte != versionByte.getValue()) {
      throw new FormatException("Version byte is invalid");
    }

    Uint8List expectedChecksum = StrKey.calculateChecksum(payload);

    if (!ListEquality().equals(expectedChecksum, checksum)) {
      throw new FormatException("Checksum invalid");
    }

    return data;
  }

  static Uint8List calculateChecksum(Uint8List bytes) {
    fixNum.Int32 crc = fixNum.Int32(0x0000);
    int count = bytes.length;
    int i = 0;
    fixNum.Int32 code;

    while (count > 0) {
      code = crc.shiftRightUnsigned(8) & 0xFF;
      code ^= bytes[i++] & 0xFF;
      code ^= code.shiftRightUnsigned(4);
      crc = crc << 8 & 0xFFFF;
      crc ^= code;
      code = code << 5 & 0xFFFF;
      crc ^= code;
      code = code << 7 & 0xFFFF;
      crc ^= code;
      count--;
    }

    // little-endian
    return Uint8List.fromList([crc.toInt(), crc.shiftRightUnsigned(8).toInt()]);
  }
}

/// Holds a Stellar keypair.
class KeyPair {
  Uint8List _mPublicKey;
  Uint8List _mPrivateKey;
  static Uint8List _mPrivateKeySeed;

  /// Creates a new KeyPair from the given [publicKey] and [privateKey].
  KeyPair(Uint8List publicKey, Uint8List privateKey) {
    _mPublicKey = checkNotNull(publicKey, "publicKey cannot be null");
    _mPrivateKey = privateKey;
  }

  /// Creates a new KeyPair object from a raw 32 byte secret [seed].
  static KeyPair fromSecretSeedList(Uint8List seed) {
    _mPrivateKeySeed = seed;
    ed25519.KeyPair kp = ed25519.Signature.keyPair_fromSeed(seed);
    return new KeyPair(kp.publicKey, kp.secretKey);
  }

  /// Generates a random Stellar KeyPair object.
  static KeyPair random() {
    Uint8List secret = ed25519.TweetNaclFast.randombytes(32);
    return fromSecretSeedList(secret);
  }

  /// Returns the human readable account ID of this key pair.
  String get accountId => StrKey.encodeStellarAccountId(_mPublicKey);
}
