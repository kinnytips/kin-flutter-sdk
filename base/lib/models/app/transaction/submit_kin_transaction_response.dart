import 'package:kin_base/models/app/interfaces/meta.dart';
import 'package:kin_base/models/app/interfaces/response.dart';
import 'package:kin_base/models/app/interfaces/status.dart';

class SubmitKinTransactionResponse implements Response {
  @override
  final MetaInformation meta;
  @override
  final Status operationStatus;

  SubmitKinTransactionResponse(this.meta, this.operationStatus);
}
