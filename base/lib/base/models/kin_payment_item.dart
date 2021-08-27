import 'package:kin_base/base/models/invoices.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_amount.dart';

///
/// @param amount - always the amount transferred in the payment
/// @param destinationAccount - the KinAccount.Id where the funds are to be transferred to
/// @param invoice - (optional) - an Invoice that this transfer refers to. [amount] should match invoice.total, but is not strictly enforced. Where they differ [amount] will be the kin actually transferred.
///
class KinPaymentItem {
  final KinAmount? amount;
  final KinAccountId destinationAccount;
  final Invoice? invoice;

  KinPaymentItem(this.amount, this.destinationAccount, [this.invoice]);

  KinPaymentItem copy(
      {KinAmount? amount, KinAccountId? destinationAccount, Invoice? invoice}) {
    return KinPaymentItem(amount ?? this.amount,
        destinationAccount ?? this.destinationAccount, invoice ?? this.invoice);
  }
}
