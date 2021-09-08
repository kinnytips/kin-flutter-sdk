import 'client_protocol_exception.dart';

class HttpResponseException implements ClientProtocolException {
  HttpResponseException(int statusCode, String s, [String? body = null]) : super() {}
}