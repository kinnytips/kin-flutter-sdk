import 'package:kin_sdk/models/gen/account/v3/account_service.pb.dart';

class AccountInfoResponse {
  final bool _isSuccess;
  final AccountInfo _accountInfo;
  final GetAccountInfoResponse_Result _result;

  const AccountInfoResponse(this._isSuccess, this._result, this._accountInfo);

  AccountInfo get accountInfo => _accountInfo;

  GetAccountInfoResponse_Result get result => _result;

  bool get isSuccess => _isSuccess;
}
