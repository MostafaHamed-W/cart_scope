import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/authentication/domain/app_user.dart';
import 'package:cart_scope/src/features/authentication/presentation/sign_in/email_password_screen_controller.dart';
import 'package:cart_scope/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements FakeAuthRepository {}

void main() {
  String testEmail = 'wafy@gmail.com';
  String testPassword = '12345678';

  group(
    "Submit",
    () {
      test(
        """ 
  given formType is signin
  when signInWithEmailAndPassword Sucess
  then return true & state is AsyncData
  """,
        () async {
          // setup
          final fakeAuthRepository = MockAuthRepository();

          when(
            () => fakeAuthRepository.signInWithEmailAndPassword(testEmail, testPassword),
          ).thenAnswer((_) => Future.value());

          final controller = EmailPasswordSignInController(
            formType: EmailPasswordSignInFormType.signIn,
            fakeAuthRepository: fakeAuthRepository,
          );

          // expect later
          expectLater(
            controller.stream,
            emitsInOrder(
              [
                EmailPasswordSignInState(
                  formType: EmailPasswordSignInFormType.signIn,
                  value: const AsyncLoading<void>(),
                ),
                EmailPasswordSignInState(
                    formType: EmailPasswordSignInFormType.signIn,
                    value: const AsyncData<void>(null)),
              ],
            ),
          );
          // run
          final result = await controller.submit(testEmail, testPassword);
          expect(result, true);
        },
        timeout: const Timeout(
          Duration(milliseconds: 500),
        ),
      );

      test(
        """ 
      given formtype is signin
      when signin with email and password is failure
      return false
      """,
        () async {
          // setup
          final fakeAuthRpository = MockAuthRepository();
          final Exception exception = Exception('Connection failed');
          when(() => fakeAuthRpository.signInWithEmailAndPassword(testEmail, testPassword))
              .thenThrow(exception);

          final controller = EmailPasswordSignInController(
            formType: EmailPasswordSignInFormType.signIn,
            fakeAuthRepository: fakeAuthRpository,
          );

          // expect later
          expectLater(
            controller.stream,
            emitsInOrder(
              [
                EmailPasswordSignInState(
                  formType: EmailPasswordSignInFormType.signIn,
                  value: const AsyncLoading<void>(),
                ),
                predicate<EmailPasswordSignInState>(
                  (state) {
                    expect(state.formType, EmailPasswordSignInFormType.signIn);
                    expect(state.value.hasError, true);
                    return true;
                  },
                )
              ],
            ),
          );

          // verify
          final result = await controller.submit(testEmail, testPassword);
          expect(result, false);
        },
      );
    },
  );
}
