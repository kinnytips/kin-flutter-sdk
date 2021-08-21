import 'dart:io';

class ClientProtocolException implements IOException {
  ClientProtocolException.empty();
  ClientProtocolException.withString(String s) : super() {  }
  ClientProtocolException(String message, [Exception cause]){
    
   }
}