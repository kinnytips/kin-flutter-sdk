import 'dart:async';

import 'package:flutter/services.dart';

class KinBaseCompatSdk {
  static const MethodChannel _channel = const MethodChannel('kin_sdk');

  static Future<String> get createAccount async {
    final String version =
        await _channel.invokeMethod('createBaseCompatAccount');
    return version;
  }
}
