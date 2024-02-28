@Timeout(Duration(milliseconds: 500))
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('String hardcoded', () {
    test('test localization string hardcoded', () {
      expect('', ''.hardcoded);
    });
  });
}
