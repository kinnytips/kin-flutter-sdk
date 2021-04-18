///
/// Used as passthrough auth params in the headers of the SubmitTransaction request
/// @param appUserId - app-user-id in the header of the request
/// @param appUserPasskey - app-user-passkey in the header of the request
///
/// For more information regarding these parameters and webhook integration
/// please consult: https://docs.kin.org/how-it-works#webhooks
///
///
class AppUserCreds {
  final String appUserId;
  final String appUserPasskey;

  AppUserCreds(this.appUserId, this.appUserPasskey);
}
