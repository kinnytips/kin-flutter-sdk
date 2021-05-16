
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/solana/transaction.dart';
import 'package:kin_base/base/network/services/kin_service.dart';

import 'kin_account_creation_api.dart';

abstract class KinAccountCreationApiV4 extends KinAccountCreationApi {

  Future<KinServiceResponse<KinAccount>> createAccountV4(Transaction transaction) ;

}
