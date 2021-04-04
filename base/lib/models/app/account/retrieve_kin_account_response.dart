import 'package:kinny/models/agora/protobuf/account/v4/account_service.pb.dart';
import 'package:kinny/models/app/account/account_response.dart';
import 'package:kinny/models/app/interfaces/meta.dart';
import 'package:kinny/models/app/interfaces/status.dart';

class GetKinAccountResponse extends AccountResponse {
  final GetAccountInfoResponse_Result result;

  GetKinAccountResponse(AccountInfo accountInfo, this.result,
      Status operationStatus, MetaInformation meta)
      : super(accountInfo, operationStatus, meta);
}
