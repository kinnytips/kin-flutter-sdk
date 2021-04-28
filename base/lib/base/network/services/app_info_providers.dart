import 'package:kin_base/base/models/app_info.dart';
import 'package:kin_base/base/models/app_user_creds.dart';

abstract class AppInfoProvider {
  AppInfo appInfo;
  AppUserCreds getPassthroughAppUserCredentials() ;
}

