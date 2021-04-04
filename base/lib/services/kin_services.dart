import 'package:kinny/models/app/account/create_kin_account_response.dart';
import 'package:kinny/models/app/agora/agora_environment.dart';
import 'package:kinny/services/account/account_service.dart';

/// Services aggregator for the all the operations possible on the Kin blockchain
class KinService {
  AccountService _accountService;

  /// To communicate with the services for various operations.
  ///
  /// To create the services pass whether the sdk is being used in production or for development
  /// Operations possible are :
  /// 1) CreateAccount
  KinService({bool isProduction = false}) {
    this._accountService =
        AccountService(AgoraEnvironment.getEndpoint(isProduction));
  }

  /// To create a fresh new account/wallet on the Kin blockchain
  Future<CreateKinAccountResponse> createAccount() async {
    return this._accountService.createAccount();
  }
}
