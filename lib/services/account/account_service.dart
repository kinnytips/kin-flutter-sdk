import 'package:grpc/grpc.dart';
import 'package:kinny/models/agora/protobuf/account/v4/account_service.pb.dart';
import 'package:kinny/models/agora/protobuf/account/v4/account_service.pbgrpc.dart';
import 'package:kinny/models/agora/protobuf/common/v4/model.pb.dart';
import 'package:kinny/models/app/account/create_kin_account_response.dart';
import 'package:kinny/models/app/interfaces/status.dart';
import 'package:kinny/models/app/sdk/constants.dart';
import 'package:logging/logging.dart';

class AccountService {
  final log = Logger('AccountService');
  final String endpoint;

  AccountService(this.endpoint);

  Future<CreateKinAccountResponse> createAccount() async {
    Transaction transaction = Transaction.create();
    var createAccountRequest = CreateAccountRequest()
      ..transaction = transaction;
    try {
      var response = await AccountClient(ClientChannel(endpoint))
          .createAccount(createAccountRequest)
          .timeout(Duration(seconds: 10));
      return CreateKinAccountResponse(
        response.accountInfo,
        response.result,
        Status(Result.SUCCESS, "Account is retrieved."),
        Constants.meta,
      );
    } catch (e) {
      log.severe("Error creating account :" + e.toString());
      return CreateKinAccountResponse(
          null,
          CreateAccountResponse_Result.BAD_NONCE,
          Status(
            Result.FAIL,
            e.toString(),
          ),
          Constants.meta);
    }
  }
}
