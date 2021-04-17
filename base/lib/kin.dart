import 'dart:async';

import 'package:kinny/models/app/account/create_kin_account_response.dart';
import 'package:kinny/models/app/account/retrieve_kin_account_response.dart';
import 'package:kinny/models/app/exceptions/account_id_not_set_exception.dart';
import 'package:kinny/models/app/interfaces/status.dart';
import 'package:kinny/services/kin_services.dart';
import 'package:logging/logging.dart';

import 'models/agora/protobuf/account/v4/account_service.pbenum.dart';

/// KinSDK allows the user to interact with the Kin blockchain
/// SDK can be instantiated either in production mode or development mode
/// When in production mode only `severe` errors are logged
/// In development mode all levels of logging is available
/// Environment must be indicated either eith `true` or with `false` while instantiating the instance.
/// SDK can also be instantiated by setting an `accountId`
class Kin {
  String _accountId;
  KinService _service;

  Kin({bool isProduction = false}) {
    this._service = KinService(isProduction: isProduction);
    if (isProduction) {
      Logger.root.level = Level.SEVERE;
    } else {
      Logger.root.level = Level.ALL;
    }

    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  String get accountId => _accountId;

  set accountId(String id) => this._accountId = id;

  /// To create a account on the Kin blockchain
  /// If account is found, the account id is added to the instance
  /// If account id already exists on the instance, this operation will override the existing accountId
  Future<CreateKinAccountResponse> createAccount() async {
    var response = await _service.createAccount();
    if (response.operationStatus.result == Result.SUCCESS &&
        response.result == CreateAccountResponse_Result.OK) {
      this.accountId = response.accountInfo.accountId.toString();
    }
    return response;
  }

  /// To retrieve an exisint wallet on the blockchain
  /// `accountId` must be present for retrieving the account details
  /// Either the `accountId` can be present because an account was created
  /// or the `accountId` must be set using `setAccountId`
  /// If `accountId` is not present, then the method will throw an exception
  /// If `accountId` is present, the account details will be fetched from the blockchain
  ///
  /// throws `AccountIdNotSetException`
  Future<RetrieveKinAccountResponse> retrieveAccount() async {
    if (this._accountId == null) {
      throw new AccountIdNotSetException(
          'Account is not set in the context. Either create an account using `createAccount` or set the account id using `setAccountId`.');
    }
    return await _service.retrieveAccount(this.accountId);
  }
}
