import 'package:cart_scope/src/features/cart/domain/item.dart';
import 'package:cart_scope/src/features/cart/presentation/add_to_cart/addToCartController.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  String productId = '1';
  group('Test AddToCartController Add Item', () {
    test(
      'item added with quantity 2, sucess',
      () {
        // Setup
        const quantity = 2;
        final cartService = MockCartService();
        final item = Item(productId: productId, quantity: quantity);
        when(() => cartService.addItem(item).then((value) => null));

        // Run & Verify
        final controller = AddToCartController(cartService: cartService);
        expect(controller.state, const AsyncData(1));
      },
    );
  });
}
