import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/cart/data/local/local_cart_repository.dart';
import 'package:cart_scope/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:cart_scope/src/features/cart/domain/cart.dart';
import 'package:cart_scope/src/features/cart/domain/mutable_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartSyncService {
  Ref ref;
  CartSyncService(this.ref) {
    _init();
  }

  _init() {
    ref.listen(authStateChangesProvider, (previous, next) {
      final previousUser = previous?.value;
      final currentUser = next.value;
      if (previousUser == null && currentUser != null) {
        debugPrint('user state changed with ${next.value?.uid}');
        _moveItemsToRemoteCart(currentUser.uid);
      }
    });
  }

  // Move all local cart items to remote cart items taking into account the available quantities
  Future<void> _moveItemsToRemoteCart(String uid) async {
    // Get local cart data
    final localCartRepository = ref.read(localCartRepositoryProvider);
    final localCart = await localCartRepository.fetchCart();
    if (localCart.items.isNotEmpty) {
      // Get remote cart data
      final remoteCartRepository = ref.read(remoteCartRepositoryProvider);
      final remoteCart = await remoteCartRepository.fetchCart(uid);
      final localItemsToAdd = localCart.toItemsList();
      // Add the local items to the remote cart
      final updatedRemoteCart = remoteCart.addItems(localItemsToAdd);
      // Write the updated remote cart data to remoteCartRepository
      await remoteCartRepository.setCart(uid, updatedRemoteCart);
      // Remove all the items from local cart
      await localCartRepository.setCart(const Cart());
    }
  }
}

final cartSyncServiceProvider = Provider<CartSyncService>((ref) {
  return CartSyncService(ref);
});
