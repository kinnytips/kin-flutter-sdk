import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_sodium/flutter_sodium.dart';
import 'package:kin_sdk/base-compat/main/backup_restore.dart';
import 'package:kin_sdk/base-compat/main/models/key_pair.dart';

class BackupRestoreImpl extends BackupRestore {
  // ignore: non_constant_identifier_names
  int SALT_LENGTH_BYTES = 16;
  // ignore: non_constant_identifier_names
  int HASH_LENGTH_BYTES = 32;

  ByteData generateRandomBytes(int len) {
    ByteData byte = new ByteData(len);
    Sodium.randombytesBuf(len);
  }
  
  String exportWallet (KeyPair keyPair, String passphrase) {
    return _exportAccountBackup(keyPair, passphrase).toString();
  }

  AccountBackup _exportAccountBackup (KeyPair keypair, String passphrase) {
    // TODO - fill this in
    String salt = "";
    String seed = "";

    return AccountBackup(keypair.accountId, salt, seed)
  }

}

class AccountBackup {
  String _publicAddress; 
  String _saltHexString; 
  String _encryptedSeedHexString;
  
  AccountBackup(String publicAddress, String saltHexString, String encryptedSeedHexString){
    _publicAddress = publicAddress;
    _saltHexString = saltHexString;
    _encryptedSeedHexString = encryptedSeedHexString;
  }

  AccountBackup.fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    _publicAddress = json['JSON_KEY_PUBLIC_KEY'];
    _saltHexString = json['JSON_KEY_SALT'];
    _encryptedSeedHexString = json['JSON_KEY_SEED'];
  }
}