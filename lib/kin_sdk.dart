import 'dart:async';

import 'package:kin_sdk/models/application/account_creation_response.dart';
import 'package:kin_sdk/models/application/account_info_response.dart';
import 'package:kin_sdk/services/kin_service.dart';
import 'package:logging/logging.dart';

class KinSdk {
  final String _accountId;
  KinService _service;

  KinSdk(this._accountId, {bool isProduction = false}) {
    this._service = KinService(isProduction: isProduction);
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  String get accountId => _accountId;

  Future<AccountCreationResponse> get createAccount =>
      _service.createAccount(this.accountId);

  Future<AccountCreationResponse> get addAccount =>
      _service.addAccount(this.accountId);

  Future<AccountInfoResponse> get getAccountInfo =>
      _service.getAccountInfo(this.accountId);
}
