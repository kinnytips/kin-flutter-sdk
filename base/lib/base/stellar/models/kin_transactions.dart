import 'package:kin_base/base/stellar/models/paging_token.dart';

import 'kin_transaction.dart';

class KinTransactions {
  final List<KinTransaction> items;

  final PagingToken headPagingToken;
  final PagingToken tailPagingToken;

  KinTransactions(this.items, [this.headPagingToken, this.tailPagingToken]);
}
