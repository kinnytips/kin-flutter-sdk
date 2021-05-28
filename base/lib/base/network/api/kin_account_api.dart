
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/network/services/kin_service.dart';

abstract class KinAccountApi {

  Future<KinServiceResponse<KinAccount>> getAccount(KinAccountId accountId) ;

}
