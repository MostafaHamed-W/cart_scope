import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  late FakeAuthRepository authRepository;
  late AccountScreenController controller;

  // run before each test
  setUp(() {
    authRepository = MockAuthRepository();
    controller = AccountScreenController(authRepository: authRepository);
  });
  group(
    'AccountScreenController Testing',
    () {
      test('initial state is AsyncValue.data', () async {
        final controller = AccountScreenController(authRepository: authRepository);
        expect(controller.state, const AsyncData<void>(null));
        verifyNever(authRepository.signOut);
        // run after each test ends
        addTearDown(() => authRepository.dispose());
      });

      test(
        'signOut success with loading state',
        () async {
          // setup
          when(authRepository.signOut).thenAnswer((_) => Future.value());

          expectLater(
            controller.stream,
            emitsInOrder(
              [
                const AsyncLoading<void>(),
                const AsyncData<void>(null),
              ],
            ),
          );
          // run
          await controller.signOut();

          //verify
          verify(authRepository.signOut).called(1);
          expect(controller.state, const AsyncData<void>(null));
          // run after each test ends
          addTearDown(() => authRepository.dispose());
        },
        timeout: const Timeout(Duration(milliseconds: 500)),
      );

      test(
        'signout failure',
        () async {
          // setup
          Exception exception = Exception('Connection failed');
          when(authRepository.signOut).thenThrow(exception);

          expectLater(
            controller.stream,
            emitsInOrder(
              [
                const AsyncLoading<void>(),
                predicate<AsyncValue<void>>((value) {
                  expect(value.hasError, true);
                  return true;
                })
              ],
            ),
          );
          //run
          await controller.signOut();

          //verify
          verify(authRepository.signOut).called(1);
          expect(controller.state.hasError, true);
          // run after each test ends
          addTearDown(() => authRepository.dispose());
        },
      );
    },
  );
}
