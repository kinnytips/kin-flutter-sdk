import 'package:kinny/models/agora/protobuf/account/v4/account_service.pb.dart';
import 'package:kinny/models/app/interfaces/meta.dart';
import 'package:kinny/models/app/interfaces/response.dart';
import 'package:kinny/models/app/interfaces/status.dart';

class AccountResponse implements Response {
  @override
  final MetaInformation meta;
  @override
  final Status operationStatus;
  final AccountInfo accountInfo;

  AccountResponse(this.accountInfo, this.operationStatus, this.meta);
}
