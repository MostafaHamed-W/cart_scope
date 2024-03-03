import 'package:cart_scope/src/features/authentication/presentation/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Cancel logout', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AccountScreen(),
        ),
      ),
    );

    final logOutButton = find.text('Logout');
    expect(logOutButton, findsOneWidget);
    await tester.tap(logOutButton);
    await tester.pump(); // to preform widget rebuild
    final alertDialogTitle = find.text('Are you sure?');
    expect(alertDialogTitle, findsOneWidget);
    final cancelButton = find.text('Cancel');
    expect(cancelButton, findsOneWidget);
  });
}
