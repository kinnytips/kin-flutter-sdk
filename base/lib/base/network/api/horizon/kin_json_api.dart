import 'dart:io';

abstract class KinJsonApi {
  KinJsonApi(ApiConfig environment, HttpClient httpClient, [KinServer server = Server(environment.networkEndpoint, okHttpClient)]) { }
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