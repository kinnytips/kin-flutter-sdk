import 'dart:core';

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/models/agora/protobuf/common/v3/model.pb.dart' as model_v3;
import 'package:kin_base/models/agora/protobuf/transaction/v3/transaction_service.pb.dart';


extension HistoryItemExtension on HistoryItem {
  KinTransaction toHistoricalKinTransaction(NetworkEnvironment networkEnvironment) {
    //TODO:
    throw UnsupportedError('No StellarKinTransaction implementation yet');
  }

  KinTransaction toAcknowledgedKinTransaction(NetworkEnvironment networkEnvironment) {
    //TODO:
    throw UnsupportedError('No StellarKinTransaction implementation yet');
  }
}

