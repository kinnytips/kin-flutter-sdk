import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_amount.dart';
import 'package:kin_base/base/models/kin_memo.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/solana/programs.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'package:kin_base/base/models/stellar_base_type_conversions.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/stellar/models/record_type.dart';
import 'package:kin_base/base/tools/charsets.dart';
import 'package:kin_base/base/tools/extensions.dart';
import 'package:kin_base/stellarfork/asset_type_credit_alphanum4.dart';
import 'package:kin_base/stellarfork/assets.dart';
import 'package:kin_base/stellarfork/memo.dart';
import 'package:kin_base/stellarfork/muxed_account.dart';
import 'package:kin_base/stellarfork/operation.dart';
import 'package:kin_base/stellarfork/payment_operation.dart';
import 'package:kin_base/stellarfork/transaction.dart' as stellarfork_tx;
import 'package:kin_base/stellarfork/xdr/xdr_data_io.dart';
import 'package:kin_base/stellarfork/xdr/xdr_operation.dart';
import 'package:kin_base/stellarfork/xdr/xdr_transaction.dart';

import 'kin_operation.dart';

extension TransactionExtension on Transaction {

  KinAmount get totalAmount => this.paymentOperations.map((e) => e.amount).reduce((value, element) => value + element ) ;

  TransactionHash get transactionHash => TransactionHash(signatures.first!.value.byteArray) ;

  KinAccountId get signingSource => message.accounts[0]!.asKinAccountId() ;

  QuarkAmount get fee => QuarkAmount(0);

  KinMemo get memo {
    var instruction = message.instructions.firstWhereOrNull((e) => message.accounts[e.programIndex] == MemoProgram.PROGRAM_KEY ) ;
    if (instruction == null) return KinMemo.none ;

    var stringBase64 = utf8.decode(instruction.data!);
    var decodedBase64 = stringBase64.isNotEmpty ? base64.decode(stringBase64) : null ;

    if (decodedBase64 != null && decodedBase64.isNotEmpty) {
      var memo = KinMemo( decodedBase64 , KinMemoTypeCharsetEncoded(Charset.utf8));

      if (memo.getAgoraMemo() != null) {
        return memo;
      } else {
        return KinMemo(instruction.data, KinMemoTypeCharsetEncoded(Charset.utf8));
      }
    }
    else {
      return KinMemo(instruction.data, KinMemoTypeCharsetEncoded(Charset.utf8));
    }
  }

  List<KinOperationPayment> get paymentOperations {
    return message.instructions.where((e) {
      var programKey = message.accounts[e.programIndex] ;
      return programKey != MemoProgram.PROGRAM_KEY
          && programKey != SystemProgram.PROGRAM_KEY
          && e.data!.first.toInt() == TokenProgramCommandTransfer().value ;
    }).map((e) {
      var int64list = e.data!.sublist(1).buffer.asInt64List();
      var amountAsLong = int64list[0] ;
      var amount = QuarkAmount(amountAsLong).toKin() ;
      var source = message.accounts[e.accounts[0]]!.asKinAccountId() ;
      var destination = message.accounts[e.accounts[1]]!.asKinAccountId() ;
      return KinOperationPayment(amount, source, destination);
    }).toList();
  }
}

abstract class KinTransaction {
  final Uint8List bytesValue;
  final RecordType recordType;
  final NetworkEnvironment? networkEnvironment;
  final QuarkAmount? fee;
  final KinMemo? memo;
  final TransactionHash? transactionHash;
  final List<KinOperationPayment>? paymentOperations;
  final InvoiceList? invoiceList;

  KinTransaction(
      this.bytesValue,
      this.recordType,
      this.networkEnvironment,
      [this.invoiceList,
      this.fee,
      this.memo,
      this.transactionHash,
      this.paymentOperations,]
      );

  KinTransaction copyWithInvoiceList(InvoiceList invoiceList) ;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KinTransaction &&
          runtimeType == other.runtimeType &&
          bytesValue.equalsContent(other.bytesValue) &&
          recordType.value == other.recordType.value &&
          networkEnvironment == other.networkEnvironment &&
          invoiceList == other.invoiceList;

  @override
  int get hashCode =>
      bytesValue.hashCode ^
      recordType.hashCode ^
      networkEnvironment.hashCode ^
      invoiceList.hashCode;
}

class SolanaKinTransaction extends KinTransaction {

  late Transaction _transaction;

  SolanaKinTransaction(Uint8List bytesValue, RecordType? recordType,
      NetworkEnvironment? networkEnvironment, [InvoiceList? invoiceLis])
      : super(
            bytesValue,
            recordType ?? RecordTypeInflight(DateTime.now().millisecondsSinceEpoch),
            networkEnvironment,
            invoiceLis) {
    this._transaction = Transaction.unmarshal(bytesValue);
  }

  TransactionHash get transactionHash => _transaction.transactionHash ;
  KinAccountId get signingSource => _transaction.signingSource ;

  QuarkAmount get fee => _transaction.fee ;

  KinMemo get memo => _transaction.memo ;

  List<KinOperationPayment> get paymentOperations => _transaction.paymentOperations ;

  SolanaKinTransaction copyWithInvoiceList(InvoiceList? invoiceList) {
    return SolanaKinTransaction(bytesValue, recordType, networkEnvironment, invoiceList);
  }

}


class StellarKinTransaction extends KinTransaction {

  StellarKinTransaction(Uint8List bytesValue, [RecordType? recordType,
      NetworkEnvironment? networkEnvironment, InvoiceList? invoiceLis])
      : super(
      bytesValue,
      recordType ?? RecordTypeInflight(DateTime.now().millisecondsSinceEpoch),
      networkEnvironment,
      invoiceLis) ;

  bool isKinNonNativeAsset() {
    return _transactionEnvelopeTX.operations.where(_isPaymentOperation)
        .map(_toPaymentOperation).map((e) {
      var asset = e.asset;
      return asset is AssetTypeCreditAlphaNum4 && asset.code == 'KIN';
    }).reduce((acc, b) => acc && b);
  }

  bool _isPaymentOperation(operation) =>
  operation
      .toOperationBody()
      .discriminant == XdrOperationType.PAYMENT;

  PaymentOperation _toPaymentOperation(Operation op) {
    var paymentOp = op.toOperationBody().paymentOp!;

    var destinationAccount = MuxedAccount.fromXdr(paymentOp.destination!);
    var asset = Asset.fromXdr(paymentOp.asset!);
    var amount = paymentOp.amount!.int64 ;

    var paymentOperation = PaymentOperationBuilder.forMuxedDestinationAccount(destinationAccount, asset, '$amount').build();
    paymentOperation.sourceAccount = op.sourceAccount ;

    return paymentOperation ;
  }

  XdrTransactionEnvelope? _transactionEnvelope;

  XdrTransactionEnvelope get transactionEnvelope =>
      _transactionEnvelope ??= _buildTransactionEnvelope();

  XdrTransactionEnvelope _buildTransactionEnvelope() {
    return XdrTransactionEnvelope.decode(XdrDataInputStream(bytesValue));
  }

  stellarfork_tx.Transaction get _transactionEnvelopeTX {
    var tx = transactionEnvelope.v0 != null ?
    stellarfork_tx.Transaction.fromV0EnvelopeXdr(transactionEnvelope.v0!) :
    stellarfork_tx.Transaction.fromV1EnvelopeXdr(transactionEnvelope.v1!) ;
    return tx;
  }

  TransactionHash? _transactionHash;

  TransactionHash get transactionHash =>
      _transactionHash ??= TransactionHash(
          _transactionEnvelopeTX.hash(networkEnvironment!.network));

  KinAccountId? _signingSource;

  KinAccountId get signingSource => _signingSource ??=
      KinAccountId.fromIdString(_transactionEnvelopeTX.sourceAccount.accountId!);

  QuarkAmount? _fee;

  QuarkAmount get fee => _fee ??= QuarkAmount(_transactionEnvelopeTX.fee);

  KinMemo? _memo ;

  KinMemo get memo => _memo ??= _buildMemo();

  KinMemo _buildMemo() {
    Memo? memo = _transactionEnvelopeTX.memo ;

    if (memo is MemoHash) {
      return KinMemo(memo.bytes);
    }
    else if (memo is MemoText) {
      return KinMemo.fromText(memo.text!, Charset.utf8);
    }
    else {
      return KinMemo.none;
    }
  }

  List<KinOperationPayment>? _paymentOperations ;

  List<KinOperationPayment> get paymentOperations => _paymentOperations ??= _buildPaymentOperations();

  List<KinOperationPayment> _buildPaymentOperations() {
    return _transactionEnvelopeTX.operations
        .where(_isPaymentOperation)
        .map((e) => _toPaymentOperation(e))
        .map((payOp) {
      return KinOperationPayment(
          KinAmount.fromString(payOp.amount),
          KinAccountId.fromIdString(payOp.sourceAccount.ed25519AccountId!),
          KinAccountId.fromIdString(payOp.destination.ed25519AccountId!));
    }).toList();
  }

  @override
  StellarKinTransaction copyWithInvoiceList(InvoiceList invoiceList) {
    return StellarKinTransaction(bytesValue, recordType, networkEnvironment, invoiceList);
  }

}
