import 'package:kin_sdk/models/application/account_creation_response.dart';
import 'package:kin_sdk/models/application/account_info_response.dart';
import 'package:kin_sdk/services/agora/account_service.dart';

class KinService {
  AccountService accountService;

  KinService() {
    this.accountService = AccountService();
  }

  Future<AccountCreationResponse> createAccount(String accountId) async {
    return this.accountService.initiateAccount(accountId);
  }

  Future<AccountCreationResponse> addAccount(String accountId) async {
    return this.accountService.initiateAccount(accountId);
  }

  Future<AccountInfoResponse> getAccountInfo(String accountId) async {
    return this.accountService.retrieveAccount(accountId);
  }
}
