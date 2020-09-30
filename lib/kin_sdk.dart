import 'dart:async';

import 'package:flutter/services.dart';

class KinSdk {
  int appIdx;
  String accountId;
  String appName;
  int appIconResourceId;
  String appUid;
  String appUserPasskey;

  KinSdk(int appIdx, String accountId, String appName, int appIconResourceId,
      String appUid, String appUserPasskey) {
    this.appIdx = appIdx;
    this.accountId = accountId;
    this.appName = appName;
    this.appIconResourceId = appIconResourceId;
    this.appUid = appUid;
    this.appUserPasskey = appUserPasskey;
  }

  static const MethodChannel _channel = const MethodChannel('kin_sdk');

  Future<String> get createAccount async {
    final String accountId = await _channel.invokeMethod('createAccount', {
      'appIdx': this.appIdx,
      'accountId': this.accountId,
      'appName': this.appName,
      'appIconResourceId': this.appIconResourceId,
      'appUid': this.appUid,
      'appUserPasskey': this.appUserPasskey,
    });
    return accountId;
  }
}
