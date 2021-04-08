import 'package:decimal/decimal.dart';

import 'kin_amount.dart';

class QuarkAmount {
  final int value;

  QuarkAmount(this.value);
}

const QUARK_CONVERSION_RATE = 100000;

extension KinToQuark on KinAmount {
  QuarkAmount toQuarks() => QuarkAmount((value * (Decimal.fromInt(QUARK_CONVERSION_RATE))).toInt());
}

extension QuarkToKin on QuarkAmount {
  KinAmount toKin() => KinAmount(Decimal.fromInt(value) / Decimal.fromInt(QUARK_CONVERSION_RATE));
}
