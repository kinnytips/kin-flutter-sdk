
import 'package:kin_base/base/models/key.dart';
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/network/services/kin_service.dart';
import 'package:kin_base/models/agora/protobuf/account/v4/account_service.pb.dart';

import 'kin_account_api.dart';

abstract class KinAccountApiV4 extends KinAccountApi {

  Future<KinServiceResponse<List<AccountInfo>>> resolveTokenAccounts(KinAccountId accountId) ;

}
