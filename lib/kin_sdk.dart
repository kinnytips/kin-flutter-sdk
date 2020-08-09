
import 'dart:async';

import 'package:flutter/services.dart';

class KinSdk {
  static const MethodChannel _channel =
      const MethodChannel('kin_sdk');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
