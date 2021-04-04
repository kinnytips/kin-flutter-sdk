import 'package:kin_sdk/base/network/services/AppInfoProvider.dart';

class AppUserAuthInterceptor {
  AppInfoProvider appInfoProvider() {
    ClientInterceptor() {
      HEADER_KEY_APP_USER_ID Metadata.Key < String > =
          Metadata.Key.of("app-user-id", Metadata.ASCII_STRING_MARSHALLER);
      HEADER_KEY_APP_USER_PASSKEY Metadata.Key < String > =
          Metadata.Key.of("app-user-passkey", Metadata.ASCII_STRING_MARSHALLER);
    }
  }
}
