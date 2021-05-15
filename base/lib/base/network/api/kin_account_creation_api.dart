
import 'package:kin_base/base/models/kin_account.dart';

abstract class KinAccountCreationApi {

  Future<KinAccount> createAccount(KinAccountId accountId) ;

}
