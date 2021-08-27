import 'kin_amount.dart';

class KinBalance {
  final KinAmount amount ;
  final KinAmount pendingAmount ;

  KinBalance([KinAmount? amount, KinAmount? pendingAmount])
      : amount = amount ?? KinAmount.zero,
        pendingAmount = pendingAmount ?? amount ?? KinAmount.zero ;

  KinBalance copy({KinAmount? amount, KinAmount? pendingAmount}) =>
      KinBalance(amount ?? this.amount, pendingAmount ?? this.pendingAmount);

  @override
  String toString() {
    return 'KinBalance{amount: $amount, pendingAmount: $pendingAmount}';
  }
}
