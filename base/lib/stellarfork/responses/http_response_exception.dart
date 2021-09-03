import 'client_protocol_exception.dart';

class HttpResponseException extends ClientProtocolException {
  HttpResponseException(int statusCode, String s, [String body = null]) : super(s) {}
}