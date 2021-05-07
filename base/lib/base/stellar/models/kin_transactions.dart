
import 'kin_transaction.dart';

class KinTransactions {
  final List<KinTransaction> items;

  final KinTransactionPagingToken headPagingToken;
  final KinTransactionPagingToken tailPagingToken;

  KinTransactions(this.items, [this.headPagingToken, this.tailPagingToken]);
}
