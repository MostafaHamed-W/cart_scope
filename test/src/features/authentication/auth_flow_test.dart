import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../robot.dart';

void main() {
  testWidgets(
    'auth flow test',
    (tester) async {
      // Mock network images
      mockNetworkImagesFor(() async {
        final r = Robot(tester);
        await r.pumpAppScreen();
        await r.expectFindAllProductCards();
      });
    },
  );
}
