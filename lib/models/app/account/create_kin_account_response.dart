import 'package:kinny/models/agora/protobuf/account/v4/account_service.pb.dart';
import 'package:kinny/models/app/account/account_response.dart';
import 'package:kinny/models/app/interfaces/meta.dart';
import 'package:kinny/models/app/interfaces/status.dart';

class CreateKinAccountResponse extends AccountResponse {
  final CreateAccountResponse_Result result;

  CreateKinAccountResponse(AccountInfo accountInfo, this.result,
      Status operationStatus, MetaInformation meta)
      : super(accountInfo, operationStatus, meta);
}
