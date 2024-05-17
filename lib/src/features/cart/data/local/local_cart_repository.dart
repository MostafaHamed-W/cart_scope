import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cart_scope/src/features/cart/domain/cart.dart';

/// API for reading, watching and writing local cart data (guest user)
abstract class LocalCartRepository {
  Future<Cart> fetchCart();

  Stream<Cart> watchCart();

  Future<void> setCart(Cart cart);
}

final localCartRepositoryProvider = Provider<LocalCartRepository>((ref) {
  // we Cannot do this because The return type of makeDefault is 'FutureProvider<SembastCartRepository>'
  // and if we made it FutureProvider we will be forced to deal with Asyncvalue. ... every time we watch the provider
  // so we choose override approach
  // return SembastCartRepository.makeDefault();
  // * Override this in the main method
  throw UnimplementedError();
});
