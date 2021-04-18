import 'package:kin_base/base/models/appidx.dart';
import 'package:kin_base/base/models/kin_account.dart';

///
/// @param appIndex - An assigned integer for this application. Make sure you are using the correct one for your app!
/// @param kinAccountId - This [KinAccount.Id] is for the account you wish to collect Kin from by default.
/// @property appName - The name of your App that can be used to display to a user in certain contexts.
/// @property appIconResourceId - The ResourceId of your app's icon.
///
class AppInfo {
  final AppIdx appIndex;
  final KinAccountId kinAccountId;
  final String appName;
  final int appIconResourceId;

  AppInfo(
    this.appIndex,
    this.kinAccountId,
    this.appName,
    this.appIconResourceId,
  );
}
