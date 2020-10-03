import 'dart:async';

import 'package:flutter/services.dart';

class KinSdk {
  int appIdx;
  String appAccountId;
  String appName;
  int appIconResourceId;
  String appUid;
  String appUserPasskey;
  String privateKey;
  String accountId;

  KinSdk.newAccount(int appIdx, String appAccountId, String appName,
      int appIconResourceId, String appUid, String appUserPasskey) {
    this.appIdx = appIdx;
    this.appAccountId = appAccountId;
    this.appName = appName;
    this.appIconResourceId = appIconResourceId;
    this.appUid = appUid;
    this.appUserPasskey = appUserPasskey;
  }

  KinSdk.existingAccount(
      int appIdx,
      String appAccountId,
      String appName,
      int appIconResourceId,
      String appUid,
      String appUserPasskey,
      String accountId,
      String privateKey) {
    this.appIdx = appIdx;
    this.appAccountId = appAccountId;
    this.appName = appName;
    this.appIconResourceId = appIconResourceId;
    this.appUid = appUid;
    this.appUserPasskey = appUserPasskey;
    this.accountId = accountId;
    this.privateKey = privateKey;
  }

  static const MethodChannel _channel = const MethodChannel('kin_sdk');

  Future<String> get createAccount async {
    final String accountId = await _channel.invokeMethod('createAccount', {
      'appIdx': this.appIdx,
      'appAccountId': this.appAccountId,
      'appName': this.appName,
      'appIconResourceId': this.appIconResourceId,
      'appUid': this.appUid,
      'appUserPasskey': this.appUserPasskey,
    });
    return accountId;
  }

  Future<String> get addAccount async {
    final String accountId = await _channel.invokeMethod('addAccount', {
      'appIdx': this.appIdx,
      'appAccountId': this.appAccountId,
      'appName': this.appName,
      'appIconResourceId': this.appIconResourceId,
      'appUid': this.appUid,
      'appUserPasskey': this.appUserPasskey,
      'accountId': this.accountId,
      'privateKey': this.privateKey,
    });
    return accountId;
  }

  Future<String> sendPayment(int value, String address) async {
    final String accountId = await _channel.invokeMethod(
        'sendPayment', {'amount': value, 'destinationAddress': address});
    return accountId;
  }

  Future<String> get getAccountInfo async {
    final String accountId = await _channel.invokeMethod('getAccountInfo');
    return accountId;
  }

  Future<String> get getTransactionHistory async {
    final String accountId =
        await _channel.invokeMethod('getTransactionHistory');
    return accountId;
  }
}
