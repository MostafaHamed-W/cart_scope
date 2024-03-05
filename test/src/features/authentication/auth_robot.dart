import 'dart:developer';

import 'package:cart_scope/src/common_widgets/alert_dialogs.dart';
import 'package:cart_scope/src/common_widgets/primary_button.dart';
import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/authentication/presentation/account/account_screen.dart';
import 'package:cart_scope/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:cart_scope/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks.dart';

class AuthRobot {
  final WidgetTester tester;
  AuthRobot(this.tester);

  Future<void> pumbEmailAndPasswordSigninScreen({
    required FakeAuthRepository fakeAuthRepository,
    required EmailPasswordSignInFormType formType,
    VoidCallback? onSignedInt,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: EmailPasswordSignInScreen(
            formType: formType,
          ),
        ),
      ),
    );
  }

  Future<void> tapSignInButton() async {
    final primaryButton = find.byType(PrimaryButton);
    expect(primaryButton, findsOneWidget);
    await tester.tap(primaryButton);
    await tester.pump();
  }

  Future<void> pumbAccountScreen({FakeAuthRepository? authRepository}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          if (authRepository != null)
            authRepositoryProvider.overrideWithValue(
              authRepository,
            )
        ],
        child: const MaterialApp(
          home: AccountScreen(),
        ),
      ),
    );
  }

  Future<void> tapLogOutButton() async {
    final logOutButton = find.text('Logout');
    expect(logOutButton, findsOneWidget);
    await tester.tap(logOutButton);
    await tester.pump(); // to preform widget rebuild
  }

  Future<void> tapLogOutAlertButton() async {
    final logOutButton = find.byKey(alertDialogKey);
    expect(logOutButton, findsOneWidget);
    await tester.tap(logOutButton);
    await tester.pump(); // to preform widget rebuild
  }

  void expectLogoutDialog() async {
    final alertDialogTitle = find.text('Are you sure?');
    expect(alertDialogTitle, findsOneWidget);
  }

  Future<void> tapCanceltButton() async {
    final cancelButton = find.text('Cancel');
    expect(cancelButton, findsOneWidget);
    await tester.tap(cancelButton);
    await tester.pump(); // to preform widget rebuild
  }

  void expectLogoutDialogNotFound() {
    final dialogTitle = find.text('Are you sure?');
    expect(dialogTitle, findsNothing);
  }

  void expectErorrDialogFound() {
    final dialogTitle = find.text('Error');
    expect(dialogTitle, findsOneWidget);
  }

  void expectErorrDialogNotFound() {
    final dialogTitle = find.text('Error');
    expect(dialogTitle, findsNothing);
  }

  void expectLoadingIndicator() {
    final finder = find.byType(CircularProgressIndicator);
    expect(finder, findsWidgets);
  }
}
