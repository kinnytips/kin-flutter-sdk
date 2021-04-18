import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kin_base/kin.dart';

void main() {
  const MethodChannel channel = MethodChannel('kin_sdk');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  /// This is a placeholder test
  /// More tests would follow
  test('Placeholder tests', () async {
    expect(true, 2 > 1);
  });
}
