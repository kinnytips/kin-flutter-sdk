import 'dart:typed_data';

import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_memo.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/stellar/models/record_type.dart';

import 'kin_operation.dart';

abstract class KinTransaction {
  final Uint8List bytesValue;
  final RecordType recordType;
  final NetworkEnvironment networkEnvironment;
  final QuarkAmount fee;
  final KinMemo memo;
  final TransactionHash transactionHash;
  final List<KinOperationPayment> paymentOperations;
  final InvoiceList invoiceList;

  KinTransaction(
      this.bytesValue,
      this.recordType,
      this.networkEnvironment,
      this.fee,
      this.memo,
      this.transactionHash,
      this.paymentOperations,
      this.invoiceList);
}

class SolanaKinTransaction extends KinTransaction {
  final Uint8List _bytesValue;
  final RecordType _recordType;
  final NetworkEnvironment _networkEnvironment;
  final QuarkAmount _fee;
  final KinMemo _memo;
  final TransactionHash _transactionHash;
  final List<KinOperationPayment> _paymentOperations;
  final InvoiceList _invoiceLis;
  Transaction _transaction;

  SolanaKinTransaction(
      this._bytesValue,
      this._recordType,
      this._networkEnvironment,
      this._fee,
      this._memo,
      this._transactionHash,
      this._paymentOperations,
      this._invoiceLis)
      : super(_bytesValue, _recordType, _networkEnvironment, _fee, _memo,
            _transactionHash, _paymentOperations, _invoiceLis) {
    this._transaction = Transaction.unmarshal(_bytesValue);
  }

  get transactionHash =>
      TransactionHash(_transaction.signatures.first.value.byteArray);

  get signingSource =>
      KinAccountId(_transaction.message.accounts[0].asPublicKey().value);

  get fee => QuarkAmount(0);

  // TODO add Get Memo according to the Kotlin class
  get memo => null;

  // TODO add paymentOperations according to the Kotlin class
  get paymentOperations => null;
}
