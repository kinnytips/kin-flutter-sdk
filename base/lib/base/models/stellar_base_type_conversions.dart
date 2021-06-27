
import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/stellarfork/key_pair.dart';
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
          this.recordType.timestamp,
          invoice: this?.invoiceList?.invoices?.elementAt(i)
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

extension KeyExtension on Key {

  KinAccountId asKinAccountId() => KinAccountId(asPublicKey().value) ;

}

extension KeyPairExtension on KeyPair {
  PublicKey asPublicKey() => PublicKey.fromBytes( this.publicKey ) ;

  PrivateKey asPrivateKey() => PrivateKey.fromBytes( this.rawSecretSeed ) ;
}

extension PrivateKeyExtension on PrivateKey {
  KeyPair toSigningKeyPair() {
    var keyPair = KeyPair.fromSecretSeedBytes(value);
    if (keyPair == null) {
      throw StateError("Cannot get a signing KeyPair");
    }
    return keyPair ;
  }
}

