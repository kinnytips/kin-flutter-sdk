import 'package:kin_base/models/agora/protobuf/account/v4/account_service.pb.dart';
import 'package:kin_base/models/app/account/account_response.dart';
import 'package:kin_base/models/app/interfaces/meta.dart';
import 'package:kin_base/models/app/interfaces/status.dart';

class RetrieveKinAccountResponse extends AccountResponse {
  final GetAccountInfoResponse_Result result;

  RetrieveKinAccountResponse(AccountInfo? accountInfo, this.result,
      Status operationStatus, MetaInformation meta)
      : super(accountInfo, operationStatus, meta);
}
