import 'dart:core';

import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/models/agora/protobuf/transaction/v3/transaction_service.pb.dart';

extension HistoryItemExtension on HistoryItem {
  KinTransaction toHistoricalKinTransaction(NetworkEnvironment networkEnvironment) {
    throw UnsupportedError('No StellarKinTransaction implementation yet');
  }

  KinTransaction toAcknowledgedKinTransaction(NetworkEnvironment networkEnvironment) {
    throw UnsupportedError('No StellarKinTransaction implementation yet');
  }
}

