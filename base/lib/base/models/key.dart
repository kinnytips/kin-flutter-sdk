import 'dart:typed_data';

import 'package:kinny/base/tools/base58.dart';
import 'package:kinny/base/tools/extensions.dart';
import 'package:kinny/stellarfork/key_pair.dart';

abstract class Key {
  Uint8List value;

  Key(this.value);

  PublicKey asPublicKey() {
    if (this is PrivateKey) {
      return PublicKey.fromBytes(KeyPair.fromSecretSeedList(value).publicKey);
    } else {
      return this as PublicKey;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Key &&
          runtimeType == other.runtimeType &&
          value.equalsContent(other.value);

  @override
  int get hashCode => value.computeHashCode();
}

class PublicKey extends Key {
  PublicKey(String publicKeyString)
      : super(KeyPair.fromAccountId(publicKeyString).publicKey);

  PublicKey.fromBytes(Uint8List publicKeyBytes) : super(publicKeyBytes);

  String toString() {
    return "PublicKey(value=${stellarBase32Encode()}, b58=${base58Encode()})";
  }

  String stellarBase32Encode() => KeyPair.fromPublicKey(value).accountId;

  String base58Encode() => Base58().encode(value);

  bool verify(Uint8List data, Uint8List value) {
    return KeyPair.fromPublicKey(this.value).verify(data, value);
  }

  static PublicKey decode(String value) =>
      PublicKey.fromBytes(KeyPair.fromAccountId(value).publicKey);
}

class PrivateKey extends Key {
  PrivateKey(String privateKeyString)
      : super(KeyPair.fromSecretSeed(privateKeyString).rawSecretSeed);

  PrivateKey.fromBytes(Uint8List privateKeyBytes)
      : super(KeyPair.fromSecretSeedList(privateKeyBytes).rawSecretSeed);

  String toString() {
    return "PrivateKey(value=XXXXXXXX<Private>XXXXXXXX)";
  }

  String stellarBase32Encode() => KeyPair.fromSecretSeedList(value).secretSeed;

  String base58Encode() => Base58().encode(value);

  Uint8List sign(Uint8List data) =>
      KeyPair.fromSecretSeedList(value).sign(data);

  static PrivateKey decode(String value) =>
      PrivateKey.fromBytes(KeyPair.fromSecretSeed(value).privateKey);

  static PrivateKey random() {
    return PrivateKey.fromBytes(KeyPair.random().rawSecretSeed);
  }
}
