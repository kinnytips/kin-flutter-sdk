import 'package:kin_base/base/models/app_info.dart';
import 'package:kin_base/base/network/models/app_info.dart';
import 'package:kin_base/base/network/models/app_user_creds.dart';

class AppInfoProvider {
  AppInfo appInfo;
  AppUserCreds getPassthroughAppUserCredentials;
}