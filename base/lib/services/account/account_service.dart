import 'package:grpc/grpc.dart';
import 'package:kin_base/models/agora/protobuf/account/v4/account_service.pb.dart';
import 'package:kin_base/models/agora/protobuf/account/v4/account_service.pbgrpc.dart';
import 'package:kin_base/models/agora/protobuf/common/v4/model.pb.dart';
import 'package:kin_base/models/app/account/create_kin_account_response.dart';
import 'package:kin_base/models/app/account/retrieve_kin_account_response.dart';
import 'package:kin_base/models/app/interfaces/status.dart';
import 'package:kin_base/models/app/sdk/constants.dart';
import 'package:logging/logging.dart';

class AccountService {
  final log = Logger('AccountService');
  final String endpoint;

  AccountService(this.endpoint);

  Future<CreateKinAccountResponse> createAccount() async {
    // TODO add transaction.value
    // Transaction.Value contains the instructions for creating the account
    var transaction = Transaction();
    var createAccountRequest = CreateAccountRequest()
      ..transaction = transaction;
    try {
      var response = await AccountClient(ClientChannel(endpoint))
          .createAccount(createAccountRequest)
          .timeout(Duration(seconds: 10));
      return CreateKinAccountResponse(
        response.accountInfo,
        response.result,
        Status(
          Result.SUCCESS,
          "Account is retrieved.",
        ),
        Constants.meta,
      );
    } catch (e) {
      log.severe(
        "Error creating account :" + e.toString(),
      );
      return CreateKinAccountResponse(
        null,
        CreateAccountResponse_Result.BAD_NONCE,
        Status(
          Result.FAIL,
          e.toString(),
        ),
        Constants.meta,
      );
    }
  }

  Future<RetrieveKinAccountResponse> getAccountInfo(String id) async {
    // TODO Convert String id to byte array
    // TODO SolanaAccountId needs string id converted to ByteArray
    var accountId = SolanaAccountId();
    var getAccountRequest = GetAccountInfoRequest()..accountId = accountId;

    try {
      var response = await AccountClient(ClientChannel(endpoint))
          .getAccountInfo(getAccountRequest)
          .timeout(Duration(seconds: 10));
      return RetrieveKinAccountResponse(
        response.accountInfo,
        response.result,
        Status(Result.SUCCESS, "Account is retrieved."),
        Constants.meta,
      );
    } catch (e) {
      log.severe("Error fetching account information : " + e.toString());
      return RetrieveKinAccountResponse(
        null,
        GetAccountInfoResponse_Result.NOT_FOUND,
        Status(
          Result.FAIL,
          e.toString(),
        ),
        Constants.meta,
      );
    }
  }
}
