import 'package:kin_base/models/app/interfaces/meta.dart';
import 'package:kin_base/models/app/interfaces/status.dart';

abstract class Response {
  final MetaInformation meta;
  final Status operationStatus;

  Response(this.meta, this.operationStatus);
}
