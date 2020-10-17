import 'dart:convert';

import 'package:kin_sdk/base-compat/main/backup_restore.dart';
import 'package:kin_sdk/base-compat/main/models/key_pair.dart';

class BackupRestoreImpl extends BackupRestore {
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