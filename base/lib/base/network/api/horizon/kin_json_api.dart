import 'dart:io';

import 'package:kin_base/base/stellar/models/api_config.dart';
import 'package:kin_base/stellarfork/kinserver.dart';
import 'package:kin_base/stellarfork/server.dart';

abstract class KinJsonApi {
  KinServer server;
  KinJsonApi(ApiConfig environment, HttpClient httpClient) {
    server = Server(environment.networkEndpoint, httpClient);
   }
}

class MalformedBodyExcpetion implements Exception {
  String _message;
  MalformedBodyExcpetion([String message = 'Malformed Body']) {
    this._message = message;
  }
}

class TimeoutException implements Exception {
  String _message;
  TimeoutException([String message = 'Timed Out']) {
    this._message = message;
  }
}