import 'dart:convert';
import 'dart:typed_data';
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_amount.dart';
import 'package:kin_base/base/models/kin_memo.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/solana/instruction.dart';
import 'package:kin_base/base/models/solana/programs.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'package:kin_base/base/models/transaction_hash.dart';
import 'package:kin_base/base/stellar/models/kin_transactions.dart';
import 'package:kin_base/base/stellar/models/network_environment.dart';
import 'package:kin_base/base/stellar/models/record_type.dart';
import 'package:kin_base/base/tools/charsets.dart';

import 'package:kin_base/base/models/stellar_base_type_conversions.dart';

import 'kin_operation.dart';

extension TransactionExtension on Transaction {

  KinAmount get totalAmount => this.paymentOperations.map((e) => e.amount).reduce((value, element) => value + element ) ;

  TransactionHash get transactionHash => TransactionHash(signatures.first.value.byteArray) ;

  KinAccountId get signingSource => message.accounts[0].asKinAccountId() ;

  QuarkAmount get fee => QuarkAmount(0);

  KinMemo get memo {
    var instruction = message.instructions.firstWhere((e) => message.accounts[e.programIndex] == MemoProgram.PROGRAM_KEY , orElse: () => null) ;
    if (instruction == null) return KinMemo.none ;

    var stringBase64 = utf8.decode(instruction.data);
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
          && e.data.first.toInt() == TokenProgramCommandTransfer().value ;
    }).map((e) {
      var amountAsLong = e.data.buffer.asInt64List(1)[0] ;
      var amount = QuarkAmount(amountAsLong).toKin() ;
      var source = message.accounts[e.accounts[0]].asKinAccountId() ;
      var destination = message.accounts[e.accounts[1]].asKinAccountId() ;
      return KinOperationPayment(amount, source, destination);
    }).toList();
  }
}

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
      [this.invoiceList,
      this.fee,
      this.memo,
      this.transactionHash,
      this.paymentOperations,]
      );

  KinTransaction copyWithInvoiceList(InvoiceList invoiceList) ;
}

class SolanaKinTransaction extends KinTransaction {

  Transaction _transaction;

  SolanaKinTransaction(
      Uint8List bytesValue,
      RecordType recordType,
      NetworkEnvironment networkEnvironment,
      InvoiceList invoiceLis)
      : super(bytesValue, recordType, networkEnvironment, invoiceLis) {
    this._transaction = Transaction.unmarshal(bytesValue);
  }

  TransactionHash get transactionHash => _transaction.transactionHash ;
  KinAccountId get signingSource => _transaction.signingSource ;

  QuarkAmount get fee => _transaction.fee ;

  KinMemo get memo => _transaction.memo ;

  List<KinOperationPayment> get paymentOperations => _transaction.paymentOperations ;

  SolanaKinTransaction copyWithInvoiceList(InvoiceList invoiceList) {
    return SolanaKinTransaction(bytesValue, recordType, networkEnvironment, invoiceList);
  }

}
