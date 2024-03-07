import 'package:cart_scope/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../robot.dart';

void main() {
  final sizeVariant = ValueVariant<Size>(
    {
      const Size(300, 300),
      const Size(600, 600),
      const Size(1000, 1000),
    },
  );
  testWidgets(
    'Golden - products list',
    (tester) async {
      final r = Robot(tester);
      // get current surface size
      final currentSize = sizeVariant.currentValue!;
      // set current surface size
      await r.golden.setSurfaceSize(currentSize);
      await r.golden.loadRobotoFont();
      await r.golden.loadMaterialIconFont();
      await mockNetworkImagesFor(() async {
        await r.pumpMyApp();
      });
      await r.golden.precacheImages();
      await expectLater(
        find.byType(CartScope),
        matchesGoldenFile(
          'products_list_${(currentSize.width.toInt())} * ${(currentSize.height.toInt())}.png',
        ),
      );
    },
    variant: sizeVariant,
    tags: ['golden'],
    // Skip this test until we can run it successfully on CI without this error:
    // Golden "products_list_300x600.png": Pixel test failed, 2.33% diff detected.
    skip: true,
  );
}
