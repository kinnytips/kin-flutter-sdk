import 'package:kin_sdk/models/gen/account/v3/account_service.pb.dart';

class AccountCreationResponse {
  final bool _isSuccess;
  final CreateAccountResponse_Result _result;
  final AccountInfo _accountInfo;

  const AccountCreationResponse(
      this._isSuccess, this._result, this._accountInfo);

  AccountInfo get accountInfo => _accountInfo;

  CreateAccountResponse_Result get result => _result;

  bool get isSuccess => _isSuccess;
}
