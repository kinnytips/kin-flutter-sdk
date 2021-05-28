
import 'package:kin_base/base/models/kin_account.dart';
import 'package:kin_base/base/models/kin_amount.dart';

class KinOperation {

}

class KinOperationPayment extends KinOperation {
  final KinAmount amount;
  final KinAccountId source;
  final KinAccountId destination ;

  KinOperationPayment(this.amount, this.source, this.destination);
}
