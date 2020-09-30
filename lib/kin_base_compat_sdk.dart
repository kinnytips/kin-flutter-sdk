import 'dart:async';

import 'package:flutter/services.dart';

class KinBaseCompatSdk {
  String appId;
  bool isProduction;
  KinBaseCompatSdk(String appId, {bool isProduction = false}) {
    this.appId = appId;
    this.isProduction = isProduction;
  }
  static const MethodChannel _channel = const MethodChannel('kin_sdk');

  Future<String> get createAccount async {
    final String accountId = await _channel.invokeMethod(
        'createBaseCompatAccount',
        {'appId': this.appId, 'isProdcution': this.isProduction});
    return accountId;
  }
}
