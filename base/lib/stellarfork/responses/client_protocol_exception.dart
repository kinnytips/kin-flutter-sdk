import 'dart:io';

class ClientProtocolException implements IOException {
  ClientProtocolException.empty();

  ClientProtocolException.withString(String s) : this(s);

  ClientProtocolException(String message, [Exception cause]) {}
}
