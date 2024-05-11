import 'package:cart_scope/src/features/cart/application/cart_service.dart';
import 'package:cart_scope/src/features/cart/domain/item.dart';
import 'package:cart_scope/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToCartController extends StateNotifier<AsyncValue<int>> {
  AddToCartController({required this.cartService}) : super(const AsyncData(1));
  final CartService cartService;

  void updateQuantity(int quantity) {
    state = AsyncData(quantity);
  }

  void addItemToCart(ProductID productID) async {
    final item = Item(productId: productID, quantity: state.value!);
    state = const AsyncLoading<int>().copyWithPrevious(state);
    final value = await AsyncValue.guard(() => cartService.addItem(item));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = const AsyncData(1);
    }
  }
}

// TODO: Should this use autoDispose?
final addToCartControllerProvider = StateNotifierProvider<AddToCartController, AsyncValue<int>>((ref) {
  return AddToCartController(cartService: ref.watch(cartServiceProvider));
});
