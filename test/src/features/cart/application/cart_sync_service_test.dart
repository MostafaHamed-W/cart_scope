import 'package:cart_scope/src/constants/test_products.dart';
import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/authentication/domain/app_user.dart';
import 'package:cart_scope/src/features/cart/application/cart_sync_service.dart';
import 'package:cart_scope/src/features/cart/data/local/local_cart_repository.dart';
import 'package:cart_scope/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:cart_scope/src/features/cart/domain/cart.dart';
import 'package:cart_scope/src/features/products/data/fake_products_repository.dart';
import 'package:cart_scope/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late MockLocalCartRepository localCartRepository;
  late MockRemoteCartRepository remoteCartRepository;
  late MockProductsRepository productsRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    localCartRepository = MockLocalCartRepository();
    remoteCartRepository = MockRemoteCartRepository();
    productsRepository = MockProductsRepository();
  });

  CartSyncService makeCartSyncService() {
    final container = ProviderContainer(overrides: [
      authRepositoryProvider.overrideWithValue(authRepository),
      localCartRepositoryProvider.overrideWithValue(localCartRepository),
      remoteCartRepositoryProvider.overrideWithValue(remoteCartRepository),
      productsRepositoryProvider.overrideWithValue(productsRepository),
    ]);
    addTearDown(container.dispose);
    return container.read(cartSyncServiceProvider);
  }

  group(
    'CartSync Service Test',
    () {
      Future<void> runCartSyncTest({
        required Map<ProductID, int> localCartItems,
        required Map<ProductID, int> remoteCartItems,
        required Map<ProductID, int> expectedRemoteCartItems,
      }) async {
        const uid = '123';
        when(authRepository.authStateChanges).thenAnswer(
          (_) => Stream.value(const AppUser(uid: uid, email: 'test@test.com')),
        );
        when(productsRepository.fetchProductsList).thenAnswer((_) => Future.value(kTestProducts));
        when(localCartRepository.fetchCart).thenAnswer((_) => Future.value(Cart(localCartItems)));
        when(() => remoteCartRepository.fetchCart(uid)).thenAnswer((_) => Future.value(Cart(remoteCartItems)));
        when(() => remoteCartRepository.setCart(uid, Cart(expectedRemoteCartItems))).thenAnswer((_) => Future.value());
        when(() => localCartRepository.setCart(const Cart())).thenAnswer((_) => Future.value());
        // create cart sync service (return value not needed)
        makeCartSyncService();
        // wait for all the stubbed methods to return a value
        await Future.delayed(const Duration());
        // verify
        verify(() => remoteCartRepository.setCart(
              uid,
              Cart(expectedRemoteCartItems),
            )).called(1);
        verify(() => localCartRepository.setCart(
              const Cart(),
            )).called(1);
      }

      test('local quantity <= available quantity', () async {
        await runCartSyncTest(
          localCartItems: {'1': 1},
          remoteCartItems: {},
          expectedRemoteCartItems: {'1': 1},
        );
      });
      test('local quantity > available quantity', () async {
        await runCartSyncTest(
          localCartItems: {'1': 15},
          remoteCartItems: {},
          expectedRemoteCartItems: {'1': 5},
        );
      });
    },
  );
}
