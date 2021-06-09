import 'dart:typed_data';

import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/network/api/kin_account_creation_api.dart';
import 'package:kin_base/base/tools/extensions.dart';

import 'invoices.dart';
import 'kin_amount.dart';
import 'kin_memo.dart';
import 'quark_amount.dart';
import 'transaction_hash.dart';

class KinPaymentId {
  final TransactionHash transactionHash;

  final int offset;

  KinPaymentId(this.transactionHash, this.offset);

  Uint8List _value;

  Uint8List get value {
    if (_value == null) {
      var rawValue = transactionHash.rawValue;
      var offsetBytes = offset.toUint8List();
      _value = Uint8List(rawValue.length + offsetBytes.length)
        ..addAll(rawValue)
        ..addAll(offsetBytes);
    }
    return _value;
  }
}

class KinPaymentStatus {
  final int value;

  KinPaymentStatus(this.value);
}

class KinPaymentStatusInFlight extends KinPaymentStatus {
  static final KinPaymentStatusInFlight _instance =
      KinPaymentStatusInFlight._();

  KinPaymentStatusInFlight._() : super(0);

  factory KinPaymentStatusInFlight() => _instance;
}

class KinPaymentStatusSuccess extends KinPaymentStatus {
  static final KinPaymentStatusSuccess _instance = KinPaymentStatusSuccess._();

  KinPaymentStatusSuccess._() : super(1);

  factory KinPaymentStatusSuccess() => _instance;
}

class KinPaymentStatusError extends KinPaymentStatus {
  final KinPaymentErrorReason reason;

  KinPaymentStatusError(this.reason) : super(2);
}

class KinPaymentErrorReason {
  final int errorCode;
  final String displayableReason;

  KinPaymentErrorReason(this.errorCode, this.displayableReason);
}

class KinPayment {
  final KinPaymentId id;

  final KinPaymentStatus status;

  final KinAccountId sourceAccountId;

  final KinAccountId destinationAccountId;

  final KinAmount amount;

  final QuarkAmount fee;

  final KinMemo memo;
  final int timestamp;
  final Invoice invoice;

  KinPayment(
      this.id,
      this.status,
      this.sourceAccountId,
      this.destinationAccountId,
      this.amount,
      this.fee,
      this.memo,
      this.timestamp,
      {this.invoice});

  @override
  String toString() {
    return 'KinPayment{id: $id, status: $status, sourceAccountId: $sourceAccountId, destinationAccountId: $destinationAccountId, amount: $amount, fee: $fee, memo: $memo, timestamp: $timestamp, invoice: $invoice}';
  }
}
