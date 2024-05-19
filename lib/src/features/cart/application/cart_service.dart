import 'dart:ffi';
import 'dart:math';

import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/cart/data/local/local_cart_repository.dart';
import 'package:cart_scope/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:cart_scope/src/features/cart/domain/cart.dart';
import 'package:cart_scope/src/features/cart/domain/item.dart';
import 'package:cart_scope/src/features/cart/domain/mutable_cart.dart';
import 'package:cart_scope/src/features/products/data/fake_products_repository.dart';
import 'package:cart_scope/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartService {
  Ref ref;

  CartService(this.ref);

  Future<Cart> _fetchCart() {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      return ref.read(remoteCartRepositoryProvider).fetchCart(user.uid);
    } else {
      return ref.read(localCartRepositoryProvider).fetchCart();
    }
  }

  Future<void> setCart(Cart cart) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      await ref.read(remoteCartRepositoryProvider).setCart(user.uid, cart);
    } else {
      await ref.read(localCartRepositoryProvider).setCart(cart);
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
  return CartService(ref);
});

final cartProvider = StreamProvider<Cart>((ref) {
  final user = ref.read(authRepositoryProvider).currentUser;
  if (user != null) {
    return ref.read(remoteCartRepositoryProvider).watchCart(user.uid);
  } else {
    return ref.read(localCartRepositoryProvider).watchCart();
  }
});

final shoppingCartIconProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.maybeMap(
    data: (cart) => cart.value.items.length,
    orElse: () => 0,
  );
});

final cartTotalPrices = Provider.autoDispose<double>((ref) {
  final cart = ref.watch(cartProvider).value ?? const Cart();
  final productList = ref.watch(productsListStreamProvider).value ?? [];
  if (cart.items.isNotEmpty && productList.isNotEmpty) {
    double total = 0.0;
    for (var item in cart.items.entries) {
      final product = productList.firstWhere((product) => product.id == item.key);
      total += product.price * item.value;
    }
    return total;
  } else {
    return 0.0;
  }
});

final itemAvailableQuantityProvider = Provider.family.autoDispose<int, Product>((ref, product) {
  final cart = ref.watch(cartProvider).value;

  if (cart != null) {
    // Get the current product quantity for the given product in cart
    final quantity = cart.items[product.id] ?? 0;
    // Subtract it from the available product quantity
    return max(0, product.availableQuantity - quantity);
  } else {
    return product.availableQuantity;
  }
});
