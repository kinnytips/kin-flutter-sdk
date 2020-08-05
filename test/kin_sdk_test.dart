import 'package:flutter_test/flutter_test.dart';

import 'package:kin_sdk/kin_sdk.dart';

void main() {
  test('adds one to input values', () {
    final calculator = Kin();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
    expect(() => calculator.addOne(null), throwsNoSuchMethodError);
  });
}
