import 'dart:typed_data';

import 'package:decimal/decimal.dart';
import 'package:kin_sdk/base-compat/main/models/transaction_id.dart';
import 'package:kin_sdk/base-compat/main/models/whitelistable_transaction.dart';
import 'package:kin_sdk/base-compat/main/xdr/xdr_transaction.dart';

import '../network.dart';
import '../util.dart';
import 'key_pair.dart';

class Transaction {
  KeyPair source;
  KeyPair destination;
  Decimal amount;
  int fee;
  String memo;

  Uint8List hash(Network network) {
    return Util.hash(this.signatureBase(network));
  }

  TransactionId id;
  XdrTransaction stellarTransaction;
  WhitelistableTransaction whitelistableTransaction;

  Uint8List signatureBase(Network network);
}