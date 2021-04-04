import 'package:async/async.dart';
import 'package:kin_sdk/base/network/models/KinAccount.dart';
import 'package:meta/meta.dart';

class KinAccountCreationApi {

  CreateAccountRequest(KinAccount.Id accountId)

  CreateAccountResponse(Result result, KinAccount account) {
    @sealed
    Result(int value) {
      Object UpgradeRequiredError() {
        Result(-3);
      }

      Object TransientFailure(Throwable error) {
        Result(-2);
      }

      Object UndefinedError(Throwable error) {
        Result(-1);
      }

      Object Ok() {
        Result(0);
      }
      Object Exists() {
        Result(1);
      }
      Object Unavailable() {
        Result(2);
      }
    }
  }

  createAccount(CreateAccountRequest request,
      CreateAccountResponse onCompleted) {}

}