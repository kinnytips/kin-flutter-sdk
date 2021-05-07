
import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_memo.dart';
import 'package:kin_base/base/models/quark_amount.dart';
import 'package:kin_base/base/models/transaction_hash.dart';

import 'kin_operation.dart';

//TODO
class RecordType {
  int timeStamp;

  RecordType(this.timeStamp);
}

class KinTransaction {
  RecordType recordType;
  QuarkAmount fee;
  KinMemo memo;
  TransactionHash transactionHash;
  List<KinOperationPayment> paymentOperations ;
  InvoiceList invoiceList;

  KinTransaction copyWithInvoiceList(InvoiceList invoiceList) {
    //TODO
  }
}

class KinTransactionPagingToken {

}

class SolanaKinTransaction {

}