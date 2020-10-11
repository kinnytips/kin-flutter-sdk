import 'package:kin_sdk/models/gen/transaction/v3/transaction_service.pb.dart';

class AccountHistoryResponse {
  final bool _isSuccess;
  final GetHistoryResponse_Result _result;
  final List<HistoryItem> _items;

  AccountHistoryResponse(this._isSuccess, this._result, this._items);

  List<HistoryItem> get getHistories => _items;

  GetHistoryResponse_Result get result => _result;

  bool get isSuccess => _isSuccess;
}
