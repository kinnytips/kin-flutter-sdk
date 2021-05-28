import 'kin_amount.dart';

class KinBalance {
  final KinAmount amount ;
  final KinAmount pendingAmount ;

  KinBalance([KinAmount amount, KinAmount pendingAmount])
      : amount = amount ?? KinAmount.zero,
        pendingAmount = pendingAmount ?? amount ?? KinAmount.zero ;
}
