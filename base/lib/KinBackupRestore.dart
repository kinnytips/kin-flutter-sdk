import 'dart:convert' as convert;
import 'dart:typed_data';

import 'package:argon2/argon2.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/tools/hex.dart';
import 'package:kin_base/base/tools/random.dart';
import 'package:kin_base/stellarfork/key_pair.dart';
import 'package:pinenacl/x25519.dart' hide IntListExtension;

class KinBackupRestore {
  KinBackupRestore();

  static const int SALT_LENGTH_BYTES = 16;

  static const int HASH_LENGTH_BYTES = 32;

  static final SecureRandom _secureRandom = SecureRandom();

  Uint8List generateRandomBytes(int length) {
    var bytes = Uint8List(length);
    _secureRandom.nextBytes(bytes, length);
    return bytes;
  }

  /// Will generate a derived key from [passphraseBytes] hashing.
  ///
  /// It's equivalent to `libsodium` (`Sodium.crypto_pwhash`).
  Uint8List _keyHash(Uint8List passphraseBytes, Uint8List saltBytes) {
    var parameters = Argon2Parameters(
      Argon2Parameters.ARGON2_id,
      saltBytes,
      version: Argon2Parameters.ARGON2_VERSION_13,
      iterations: 2,
      memory: (1 << 26) ~/ 1024,
    );

    var argon2 = Argon2BytesGenerator();
    argon2.init(parameters);

    var hash = Uint8List(HASH_LENGTH_BYTES);
    var generatedBytes = argon2.generateBytes(passphraseBytes, hash);

    if (generatedBytes != HASH_LENGTH_BYTES) {
      throw StateError("Generating hash failed: $argon2 > $parameters");
    }

    return hash;
  }

  final int _SECRET_BOX_MAC_BYTES = 16;

  final int _SECRET_BOX_NONCE_BYTES = 24;

  Uint8List _encryptSecretSeed(Uint8List hash, Uint8List secretSeedBytes) {
    var nonceBytes = generateRandomBytes(_SECRET_BOX_NONCE_BYTES);
    var encryptedBytes = SecretBox(hash).encrypt(secretSeedBytes, nonce: nonceBytes);
    return Uint8List.fromList(encryptedBytes);
  }

  Uint8List _decryptSecretSeed(Uint8List seedBytes, Uint8List hash) {
    var nonceBytes =
        Uint8List.fromList(seedBytes.sublist(0, _SECRET_BOX_NONCE_BYTES));
    var cipherBytes =
        ByteList.fromList(seedBytes.sublist(_SECRET_BOX_NONCE_BYTES));
    var decryptedBytes = SecretBox(hash).decrypt(cipherBytes, nonce: nonceBytes);
    return decryptedBytes;
  }

  AccountBackup exportWallet(String passphrase,
      {KeyPair? keyPair, KinAccountId? accountId, KinAccount? account, Uint8List? saltBytes}) {
    keyPair ??= accountId?.toKeyPair();
    keyPair ??= account?.id.toKeyPair();
    saltBytes ??= generateRandomBytes(SALT_LENGTH_BYTES);

    var passphraseBytes = convert.utf8.encode(passphrase);
    var hash = _keyHash(passphraseBytes as Uint8List, saltBytes);

    var secretSeedBytes = keyPair!.rawSecretSeed!;
    var encryptedSeed = _encryptSecretSeed(hash, secretSeedBytes);

    var saltHex = saltBytes.toHexString();
    var seedHex = encryptedSeed.toHexString();

    var accountBackup = AccountBackup(keyPair.accountId, saltHex, seedHex);

    return accountBackup;
  }

  KeyPair importWallet(dynamic accountBackup, String passphrase) {
    var accountBackupResolved = AccountBackup.from(accountBackup);

    var passphraseBytes = convert.utf8.encode(passphrase);
    var saltBytes = accountBackupResolved.saltBytes;

    var hash = _keyHash(passphraseBytes as Uint8List, saltBytes);

    var seedBytes = accountBackupResolved.encryptedSeedBytes;

    var decryptedBytes = _decryptSecretSeed(seedBytes, hash);
    return KeyPair.fromSecretSeedBytes(decryptedBytes);
  }
}

class AccountBackup {
  String? publicAddress;

  String? saltHexString;

  String? encryptedSeedHexString;

  AccountBackup(
      this.publicAddress, this.saltHexString, this.encryptedSeedHexString);

  factory AccountBackup.fromMap(Map<String, String> map) {
    return AccountBackup(map['pkey'], map['salt'], map['seed']);
  }

  factory AccountBackup.fromJson(dynamic json) {
    return AccountBackup.fromMap(json is Map
        ? json as Map<String, String>
        : (convert.json.decode('$json') as Map)
            .map((key, value) => MapEntry('$key', '$value')));
  }

  factory AccountBackup.from(dynamic o) {
    if (o is AccountBackup) {
      return o;
    } else {
      return AccountBackup.fromJson(o);
    }
  }

  Uint8List get saltBytes => _hexToBytes(saltHexString);

  Uint8List get encryptedSeedBytes => _hexToBytes(encryptedSeedHexString);

  Uint8List _hexToBytes(String? hex) {
    List<int> decode = HexCodec().decode(hex);
    return decode.toUint8List();
  }

  Map<String, String?> toMap() => <String, String?>{
        'pkey': publicAddress,
        'seed': encryptedSeedHexString,
        'salt': saltHexString
      };

  String toJson() => convert.json.encode(toMap());

  @override
  String toString() {
    return 'AccountBackup{publicAddress: $publicAddress, saltHexString: $saltHexString, encryptedSeedHexString: $encryptedSeedHexString}';
  }
}
