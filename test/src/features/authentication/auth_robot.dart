import 'package:cart_scope/src/common_widgets/alert_dialogs.dart';
import 'package:cart_scope/src/features/authentication/presentation/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthRobot {
  final WidgetTester tester;
  AuthRobot(this.tester);

  Future<void> pumbAccountScreen() async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
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
}
