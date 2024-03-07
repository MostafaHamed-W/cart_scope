import 'package:cart_scope/src/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../robot.dart';

void main() {
  testWidgets('Golden - products list', (tester) async {
    final r = Robot(tester);
    await r.golden.loadRobotoFont();
    await r.golden.loadMaterialIconFont();
    await mockNetworkImagesFor(() async {
      await r.pumpMyApp();
    });
    await r.golden.precacheImages();
    await expectLater(
      find.byType(CartScope),
      matchesGoldenFile(
        'products_list.png',
      ),
    );
  });
}
