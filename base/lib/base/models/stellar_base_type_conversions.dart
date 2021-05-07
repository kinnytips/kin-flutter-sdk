
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:protobuf/protobuf.dart';

import 'kin_payment.dart';

extension KinTransactionExtension on KinTransaction {

  List<KinPayment> asKinPayments() {
    var paymentOperations = this.paymentOperations;
    var offset = 0;

    return List<KinPayment>.generate(paymentOperations.length, (i) {
      var payment = paymentOperations[i];

      return KinPayment(
          KinPaymentId(this.transactionHash, offset++),
          KinPaymentStatusSuccess(),
          payment.source,
          payment.destination,
          payment.amount,
          this.fee,
          this.memo,
          this.recordType.timeStamp,
          invoice: this?.invoiceList?.invoices[i]
      );
    });
  }

}

extension ListKinTransactionExtension on List<KinTransaction> {

  List<KinPayment> asKinPayments([ bool reversed = false ]) {
    return this.expand((e) {
      var payments = e.asKinPayments() ;
      return reversed ? payments.reversed.toList() : payments;
    }).toList();
  }

}
