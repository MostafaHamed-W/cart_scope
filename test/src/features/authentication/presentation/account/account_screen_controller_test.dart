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
        'signOut success',
        () async {
          final authRepository = MockAuthRepository();
          when(authRepository.signOut).thenAnswer((_) => Future.value());
          final controller = AccountScreenController(authRepository: authRepository);
          await controller.signOut();
          expect(controller.state, const AsyncData<void>(null));
          verify(authRepository.signOut).called(1);
        },
      );
    },
  );
}
