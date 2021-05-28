
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/stellar/models/kin_transaction.dart';
import 'package:kin_base/base/tools/observers.dart';

abstract class KinStreamingApi {

  Observer<KinAccount> streamAccount(KinAccountId kinAccountId) ;
  Observer<KinTransaction> streamNewTransactions(KinAccountId kinAccountId) ;

}
