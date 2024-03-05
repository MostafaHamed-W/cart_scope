import 'dart:math';

import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:cart_scope/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  const testEmail = 'test@test.com';
  const testPassword = '1234';
  late FakeAuthRepository fakeAuthRepository;

  setUpAll(() {
    fakeAuthRepository = MockAuthRepository();
  });

  group('SignInScreen', () {
    testWidgets(
      '''
Given FormType is signIn
When tap on sign in button
Then signInWithEmailAndPassword not called
''',
      (tester) async {
        final r = AuthRobot(tester);
        await r.pumbEmailAndPasswordSigninScreen(
          fakeAuthRepository: fakeAuthRepository,
          formType: EmailPasswordSignInFormType.signIn,
        );
        await r.tapSignInButton();
        verifyNever(
          () {
            fakeAuthRepository.signInWithEmailAndPassword(
              any(),
              any(),
            );
          },
        );
      },
    );
  });
}
