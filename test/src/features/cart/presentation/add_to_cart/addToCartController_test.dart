import 'package:cart_scope/src/features/cart/domain/item.dart';
import 'package:cart_scope/src/features/cart/presentation/add_to_cart/addToCartController.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  const productId = '1';
  group('Test AddToCartController Add Item', () {
    test(
      'item added with quantity = 2, sucess',
      () async {
        // Setup
        const quantity = 2;
        const item = Item(productId: productId, quantity: quantity);
        final cartService = MockCartService();
        when(() => cartService.addItem(item)).thenAnswer((_) => Future.value(null));

        // Run & Verify
        final controller = AddToCartController(cartService: cartService);
        expect(controller.state, const AsyncData(1));
        controller.updateQuantity(quantity);
        expect(controller.state, const AsyncData(2));

        await controller.addItem(productId);
        verify(() => cartService.addItem(item)).called(1);

        // Ensure that quantity set back to 1 after calling addItem
        // check that quantity goes back to 1 after adding an item
        expect(
          controller.state,
          const AsyncData(1),
        );
      },
    );

    test(
      'item added with quantity = 2, sucess',
      () async {
        // Setup
        const quantity = 2;
        const item = Item(productId: productId, quantity: quantity);
        final cartService = MockCartService();
        when(() => cartService.addItem(item)).thenThrow((_) => Exception('Connection Failed'));

        // Run & Verify
        final controller = AddToCartController(cartService: cartService);
        expect(controller.state, const AsyncData(1));
        controller.updateQuantity(quantity);
        expect(controller.state, const AsyncData(2));

        await controller.addItem(productId);
        verify(() => cartService.addItem(item)).called(1);

        // check that quantity goes back to 1 after adding an item
        expect(
          controller.state,
          predicate<AsyncValue<int>>((value) {
            expect(value.hasError, true);
            return true;
          }),
        );
      },
    );
  });
}
