import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
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
      }
    });
  }
}

final cartSyncServiceProvider = Provider<CartSyncService>((ref) {
  return CartSyncService(ref);
});
