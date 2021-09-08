import 'package:kin_base/base/models/app_info.dart';
import 'package:kin_base/base/models/app_user_creds.dart';

abstract class AppInfoProvider {
  AppInfo? appInfo;
  AppUserCreds getPassthroughAppUserCredentials() ;
}

class AppInfoProviderSimple implements AppInfoProvider {

  @override
  AppInfo? appInfo;

  final String? credentialsUser ;
  final String? credentialsPass ;

  AppInfoProviderSimple(this.appInfo, this.credentialsUser, [this.credentialsPass]);

  @override
  AppUserCreds getPassthroughAppUserCredentials() {
    return new AppUserCreds(
        credentialsUser,
        credentialsPass
    );
  }

}

