import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kin_sdk/base-compat/main/models/key_pair.dart';

class BackupRestore {
  String exportWallet (KeyPair keyPair, String passphrase) {
    //TODO - Export wallet logic
    return "";
  } 

  KeyPair importWallet (String exportedJson, String passphrase) {
    return KeyPair();
  }   
}