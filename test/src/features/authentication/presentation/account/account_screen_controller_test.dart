import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  group(
    'AccountScreenController Testing',
    () {
      test('initial state is AsyncValue.data', () async {
        final authReositpry = MockAuthRepository();
        final controller = AccountScreenController(authRepository: authReositpry);
        expect(controller.state, const AsyncData<void>(null));
        verifyNever(authReositpry.signOut);
      });

      test(
        'signOut success with loading state',
        () async {
          // setup
          final authRepository = MockAuthRepository();
          when(authRepository.signOut).thenAnswer((_) => Future.value());
          final controller = AccountScreenController(authRepository: authRepository);

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
        },
        timeout: const Timeout(Duration(milliseconds: 500)),
      );

      test(
        'signout failure',
        () async {
          // setup
          final authRepository = MockAuthRepository();
          Exception exception = Exception('Connection failed');

          when(authRepository.signOut).thenThrow(exception);
          final controller = AccountScreenController(authRepository: authRepository);

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
        },
      );
    },
  );
}
