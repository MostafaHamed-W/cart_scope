import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/cart/data/local/local_cart_repository.dart';
import 'package:cart_scope/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:cart_scope/src/features/cart/domain/cart.dart';
import 'package:cart_scope/src/features/cart/domain/item.dart';
import 'package:cart_scope/src/features/cart/domain/mutable_cart.dart';
import 'package:cart_scope/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartService {
  final FakeAuthRepository authRepository;
  final LocalCartRepository localCartRepository;
  final RemoteCartRepository remoteCartRepository;

  CartService({
    required this.authRepository,
    required this.localCartRepository,
    required this.remoteCartRepository,
  });

  Future<Cart> _fetchCart() {
    final user = authRepository.currentUser;
    if (user != null) {
      return remoteCartRepository.fetchCart(user.uid);
    } else {
      return localCartRepository.fetchCart();
    }
  }

  Future<void> setCart(Cart cart) async {
    final user = authRepository.currentUser;
    if (user != null) {
      await remoteCartRepository.setCart(user.uid, cart);
    } else {
      await localCartRepository.setCart(cart);
    }
  }

  // Set an item in local or remote repository depending on the user auth state
  Future<void> setItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.setItem(item);
    await setCart(updated);
  }

  // Add an item in local or remote repository depending on the user auth state
  Future<void> addItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.addItem(item);
    await setCart(updated);
  }

  // Remove an item from local or remote repository depending on the user auth state
  Future<void> removeItem(ProductID productID) async {
    final cart = await _fetchCart();
    final updated = cart.removeItemById(productID);
    await setCart(updated);
  }
}

final cartServiceProvider = Provider<CartService>((ref) {
  return CartService(
    authRepository: ref.watch(authRepositoryProvider),
    localCartRepository: ref.watch(localCartRepositoryProvider),
    remoteCartRepository: ref.watch(remoteCartRepositoryProvider),
  );
});
