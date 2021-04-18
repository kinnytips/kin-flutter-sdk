import 'package:kinny/models/app/account/create_kin_account_response.dart';
import 'package:kinny/models/app/account/retrieve_kin_account_response.dart';
import 'package:kinny/models/app/agora/agora_environment.dart';
import 'package:kinny/models/app/transaction/submit_kin_transaction_response.dart';
import 'package:kinny/models/app/transaction/transaction_history_response.dart';
import 'package:kinny/services/account/account_service.dart';
import 'package:kinny/services/transaction/transaction_service.dart';

/// Services aggregator for the all the operations possible on the Kin blockchain
class KinService {
  AccountService _accountService;
  TransactionService _transactionService;

  /// To communicate with the services for various operations.
  ///
  /// To create the services pass whether the sdk is being used in production or for development
  /// Operations possible are :
  /// 1) CreateAccount
  /// 2) RetrieveAccount
  /// 3) LoadAccountFromDisk
  /// 4) SubmitTransaction
  /// 5) RetrieveTransactionHistory
  KinService({bool isProduction = false}) {
    var endpoint = AgoraEnvironment.getEndpoint(isProduction);
    this._accountService = AccountService(endpoint);
    this._transactionService = TransactionService(endpoint);
  }

  /// To create a fresh new account/wallet on the Kin blockchain
  Future<CreateKinAccountResponse> createAccount() async {
    return this._accountService.createAccount();
  }

  /// Retrieves an existing wallet on the blockchain
  Future<RetrieveKinAccountResponse> retrieveAccount(String accountId) async {
    return this._accountService.getAccountInfo(accountId);
  }

  /// Loads the account that is present on the disk and fetches the account info
  Future<RetrieveKinAccountResponse> loadAccountFromDisk() async {
    /// TODO add implementation to load the account from the disk
  }

  /// Submits a transaction to the blockchain
  /// TODO add all relevant parameters required for submitting a transaction
  Future<SubmitKinTransactionResponse> submitTransaction(
    double amount,
    String destinationAddress,
    double fee,
  ) async {
    return this._transactionService.submitTransaction(
          amount,
          destinationAddress,
          fee,
        );
  }

  /// Fetches the transaction history of the account
  Future<TransactionHistoryResponse> getTransactionHistory(
      String accountId) async {
    return this._transactionService.getTransactionHistory(accountId);
  }
}
