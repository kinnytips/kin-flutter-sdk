import 'package:grpc/grpc.dart';
import 'package:kin_sdk/models/application/account_info_response.dart';
import 'package:kin_sdk/models/gen/account/v3/account_service.pb.dart';
import 'package:kin_sdk/models/gen/account/v3/account_service.pbgrpc.dart';
import 'package:kin_sdk/models/gen/common/v3/model.pb.dart';
import 'package:kin_sdk/models/application/account_creation_response.dart';
import 'package:logging/logging.dart';

class AccountService {
  final log = Logger('AccountService');

  Future<AccountCreationResponse> initiateAccount(String accountId) async {
    var createAccountRequest = CreateAccountRequest()
      ..accountId = (StellarAccountId()..value = accountId);
    if (createAccountRequest.hasAccountId()) {
      try {
        var response = await AccountClient(ClientChannel("api.agorainfra.dev"))
            .createAccount(createAccountRequest)
            .timeout(Duration(seconds: 10));
        return AccountCreationResponse(
            true, response.result, response.accountInfo);
      } catch (e) {
        log.severe("Error creating account :" + e.toString());
        return AccountCreationResponse(false, null, null);
      }
    } else {
      log.severe("Account id is not available");
      return AccountCreationResponse(false, null, null);
    }
  }

  Future<AccountInfoResponse> retrieveAccount(String accountId) async {
    var createAccountRequest = GetAccountInfoRequest()
      ..accountId = (StellarAccountId()..value = accountId);
    if (createAccountRequest.hasAccountId()) {
      try {
        var response = await AccountClient(ClientChannel("api.agorainfra.dev"))
            .getAccountInfo(createAccountRequest)
            .timeout(Duration(seconds: 10));
        return AccountInfoResponse(true, response.result, response.accountInfo);
      } catch (e) {
        log.severe("Error creating account :" + e.toString());
        return AccountInfoResponse(
            false, GetAccountInfoResponse_Result.NOT_FOUND, null);
      }
    } else {
      log.severe("Account id is not available");
      return AccountInfoResponse(
          false, GetAccountInfoResponse_Result.NOT_FOUND, null);
    }
  }
}
