import 'package:cart_scope/src/features/authentication/domain/app_user.dart';
import 'package:cart_scope/src/features/authentication/presentation/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  testWidgets('Cancel logout', (tester) async {
    AuthRobot r = AuthRobot(tester);
    await r.pumbAccountScreen();
    await r.tapLogOutButton();
    r.expectLogoutDialog();
    await r.tapCanceltButton();
    r.expectLogoutDialogNotFound();
    r.expectErorrDialogNotFound();
  });

  testWidgets('Confirm logout, sucess', (tester) async {
    AuthRobot r = AuthRobot(tester);
    await r.pumbAccountScreen();
    await r.tapLogOutButton();
    r.expectLogoutDialog();
    await r.tapLogOutAlertButton();
    r.expectErorrDialogNotFound();
    r.expectErorrDialogNotFound();
  });

  testWidgets('Confirm logout, failure', (tester) async {
    AuthRobot r = AuthRobot(tester);
    Exception exception = Exception('Error');
    final authRepository = MockAuthRepository();
    when(authRepository.signOut).thenThrow(exception);
    when(authRepository.authStateChanges).thenAnswer(
      (_) => Stream.value(
        const AppUser(uid: '123', email: 'wafy@gmail.com'),
      ),
    );
    await r.pumbAccountScreen(authRepository: authRepository);
    await r.tapLogOutButton();
    r.expectLogoutDialog();
    await r.tapLogOutAlertButton();
    r.expectErorrDialogFound();
  });

  testWidgets('logout, loading state', (tester) async {
    AuthRobot r = AuthRobot(tester);
    final authRepository = MockAuthRepository();
    when(authRepository.signOut).thenAnswer(
      (_) => Future.delayed(const Duration(seconds: 2)),
    );
    when(authRepository.authStateChanges).thenAnswer(
      (_) => Stream.value(
        const AppUser(uid: '123', email: 'wafy@gmail.com'),
      ),
    );
    await r.pumbAccountScreen(authRepository: authRepository);
    await tester.runAsync(() async {
      await r.tapLogOutButton();
      r.expectLogoutDialog();
      await r.tapLogOutAlertButton();
      r.expectLogoutDialogNotFound();
    });
    r.expectLoadingIndicator();
  });
}
