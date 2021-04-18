import 'package:kinny/models/app/interfaces/meta.dart';
import 'package:kinny/models/app/interfaces/response.dart';
import 'package:kinny/models/app/interfaces/status.dart';

class TransactionHistoryResponse implements Response {
  @override
  final MetaInformation meta;
  @override
  final Status operationStatus;

  TransactionHistoryResponse(this.meta, this.operationStatus);
}