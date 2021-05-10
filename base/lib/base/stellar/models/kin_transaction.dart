import 'dart:convert';
import 'dart:typed_data';
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_memo.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/solana/instruction.dart';
import 'package:kin_base/base/models/solana/programs.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/stellar/models/record_type.dart';
import 'package:kin_base/base/tools/charsets.dart';

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

  KinMemo get memo {
    CompiledInstruction compiledInstruction;

    for (CompiledInstruction instruction in _transaction.message.instructions) {
      if (_transaction.message.accounts[instruction.programIndex] ==
          MemoProgram.PROGRAM_KEY) {
        compiledInstruction = instruction;
        break;
      }
    }

    if (compiledInstruction == null) {
      return KinMemo.none;
    }
    var base64Decoded = base64.decode(base64.encode(compiledInstruction.data));

    if (base64Decoded == null) {
      return KinMemo.fromText(
          String.fromCharCodes(compiledInstruction.data), Charset.utf8);
    }

    var memo = KinMemo(base64Decoded);

    if (memo.getAgoraMemo == null) {
      return KinMemo(
          compiledInstruction.data, KinMemoTypeCharsetEncoded(Charset.utf8));
    }

    return memo;
  }

  // TODO add paymentOperations according to the Kotlin class
  get paymentOperations => null;
}
