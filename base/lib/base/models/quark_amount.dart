import 'package:decimal/decimal.dart';

import 'kin_amount.dart';

class QuarkAmount {
  final int? value;

  QuarkAmount(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuarkAmount &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'QuarkAmount{value: $value}';
  }
}

const QUARK_CONVERSION_RATE = 100000;

extension KinToQuark on KinAmount {
  QuarkAmount toQuarks() => QuarkAmount((value * (Decimal.fromInt(QUARK_CONVERSION_RATE))).toInt());
}

extension QuarkToKin on QuarkAmount {
  KinAmount toKin() => KinAmount(Decimal.fromInt(value!) / Decimal.fromInt(QUARK_CONVERSION_RATE));
}
