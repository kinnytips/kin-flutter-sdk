import 'package:kin_base_storage/kin_base_storage.dart';
import 'package:test/test.dart';

void main() {
  group('proto', () {
    test('PrivateKey', () {
      expect(PrivateKey.create(), isNotNull);
    });
  });
}
