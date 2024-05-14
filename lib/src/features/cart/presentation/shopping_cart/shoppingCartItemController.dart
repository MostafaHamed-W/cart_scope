import 'package:cart_scope/src/features/cart/application/cart_service.dart';
import 'package:cart_scope/src/features/cart/domain/item.dart';
import 'package:cart_scope/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingCartItemController extends StateNotifier<AsyncValue<void>> {
  ShoppingCartItemController({required this.cartService}) : super(const AsyncData(null));
  final CartService cartService;

  Future<void> updateCartItem(ProductID productID, int quantity) async {
    state = const AsyncLoading();
    final updated = Item(productId: productID, quantity: quantity);
    state = await AsyncValue.guard(() => cartService.setItem(updated));
  }

  Future<void> removeCartItem(ProductID productID) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => cartService.removeItem(productID));
  }
}

final shoppingCartItemContollerProvider = StateNotifierProvider<ShoppingCartItemController, AsyncValue<void>>((ref) {
  final cartService = ref.watch(cartServiceProvider);
  return ShoppingCartItemController(cartService: cartService);
});
