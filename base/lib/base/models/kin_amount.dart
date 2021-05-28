import 'package:decimal/decimal.dart';

class KinAmount {
  static const int MAX_PRECISION = 5;

  static final KinAmount zero = KinAmount(Decimal.zero);
  static final KinAmount one = KinAmount(Decimal.one);

  final Decimal amount;

  KinAmount(this.amount);

  KinAmount.fromString(String amount) : this(Decimal.parse(amount));

  KinAmount.fromDecimal(Decimal amount) : this(amount);

  KinAmount.fromInt(int amount) : this(Decimal.fromInt(amount));

  KinAmount.fromDouble(double amount) : this(Decimal.parse(amount.toString()));

  static KinAmount max(KinAmount a, KinAmount b) {
    var max = a.amount > b.amount ? a.amount : b.amount ;
    return KinAmount(max);
  }

  Decimal get value => Decimal.parse(toStringWithPrecision(MAX_PRECISION));

  String toString() => toStringWithPrecision(MAX_PRECISION);

  String toStringWithPrecision(int precision) =>
      amount.toStringAsFixed(precision);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KinAmount &&
          runtimeType == other.runtimeType &&
          amount == other.amount;

  @override
  int get hashCode => amount.hashCode;

  KinAmount operator +(KinAmount other) {
    return KinAmount(this.amount + other.amount);
  }

  KinAmount operator -(KinAmount other) {
    return KinAmount(this.amount - other.amount);
  }

  KinAmount operator *(KinAmount other) {
    return KinAmount(this.amount * other.amount);
  }

  KinAmount operator /(KinAmount other) {
    return KinAmount(this.amount / other.amount);
  }
}
