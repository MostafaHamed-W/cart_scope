import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/authentication/domain/app_user.dart';
import 'package:cart_scope/src/features/cart/application/cart_service.dart';
import 'package:cart_scope/src/features/cart/data/local/local_cart_repository.dart';
import 'package:cart_scope/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:cart_scope/src/features/cart/domain/cart.dart';
import 'package:cart_scope/src/features/cart/domain/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(const Cart());
  });

  late MockAuthRepository mockAuthRepository;
  late MockLocalCartRepository mockLocalCartRepository;
  late MockRemoteCartRepository mockRemoteCartRepository;

  setUp(() => {
        mockAuthRepository = MockAuthRepository(),
        mockLocalCartRepository = MockLocalCartRepository(),
        mockRemoteCartRepository = MockRemoteCartRepository(),
      });

  CartService makeCartService() {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepository),
        localCartRepositoryProvider.overrideWithValue(mockLocalCartRepository),
        remoteCartRepositoryProvider.overrideWithValue(mockRemoteCartRepository),
      ],
    );
    addTearDown(container.dispose);
    return container.read(cartServiceProvider);
  }

  group('Test CartServices methods', () {
    test(
      'null users, write items to local cart',
      () async {
        const expectedCart = Cart({"123": 2});

        // Setup mocks
        when(() => mockAuthRepository.currentUser).thenReturn(null);
        when(() => mockLocalCartRepository.fetchCart()).thenAnswer((_) => Future.value(const Cart()));
        when(() => mockLocalCartRepository.setCart(expectedCart)).thenAnswer((invocation) => Future.value());
        final cartService = makeCartService();

        // Run
        await cartService.setItem(const Item(productId: '123', quantity: 2));

        // Verify
        verify(() => mockLocalCartRepository.setCart(expectedCart)).called(1);
        verifyNever(() => mockRemoteCartRepository.setCart(any(), any()));
      },
    );

    test(
      'nont-null users, write items to remote cart',
      () async {
        const expectedCart = Cart({"123": 2});
        const user = AppUser(uid: 'abc', email: 'xwafy31@gmail.com');

        // Setup mocks
        when(() => mockAuthRepository.currentUser).thenReturn(user);
        when(() => mockRemoteCartRepository.fetchCart(user.uid)).thenAnswer((_) => Future.value(expectedCart));
        when(() => mockRemoteCartRepository.setCart(user.uid, expectedCart)).thenAnswer((invocation) => Future.value());
        final cartService = makeCartService();

        // Run
        await cartService.setItem(const Item(productId: '123', quantity: 2));

        // Verify
        verify(() => mockRemoteCartRepository.setCart(user.uid, expectedCart)).called(1);
        verifyNever(() => mockLocalCartRepository.setCart(any()));
      },
    );
  });
}
