import 'package:fixnum/fixnum.dart';
import 'package:kin_sdk/models/gen/transaction/v3/transaction_service.pb.dart';

class AccountTransactionResponse {
  final bool _isSuccess;
  final HistoryItem _item;
  final Int64 _ledger;

  AccountTransactionResponse(this._isSuccess, this._item, this._ledger);

  HistoryItem get getHistory => _item;

  Int64 get result => _ledger;

  bool get isSuccess => _isSuccess;
}
