import 'dart:async';

import 'package:kin_sdk/models/application/account_creation_response.dart';
import 'package:kin_sdk/services/kin_service.dart';
import 'package:logging/logging.dart';

class KinSdk {
  String _accountId;
  KinService service;

  KinSdk(this._accountId) {
    this.service = KinService();
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.level.name}: ${record.time}: ${record.message}');
    });
  }

  String get accountId => _accountId;

  Future<AccountCreationResponse> get createAccount =>
      service.createAccount(this.accountId);

  Future<AccountCreationResponse> get addAccount =>
      service.addAccount(this.accountId);
}
