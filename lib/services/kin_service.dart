import 'package:kin_sdk/models/application/account_creation_response.dart';
import 'package:kin_sdk/models/application/account_history_response.dart';
import 'package:kin_sdk/models/application/account_info_response.dart';
import 'package:kin_sdk/services/agora/account_service.dart';
import 'package:kin_sdk/services/agora/agora_info.dart';
import 'package:kin_sdk/services/agora/transaction_service.dart';

class KinService {
  AccountService accountService;
  TransactionService transactionService;

  KinService({bool isProduction = false}) {
    this.accountService = AccountService(AgoraInfo.getEndpoint(isProduction));
    this.transactionService =
        TransactionService(AgoraInfo.getEndpoint(isProduction));
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

  Future<AccountHistoryResponse> getAccountHistory(String accountId) async {
    return this.transactionService.getAccountHistory(accountId);
  }

  Future<AccountHistoryResponse> getTransaction(String transactionId) async {
    return this.transactionService.getAccountHistory(transactionId);
  }
}
