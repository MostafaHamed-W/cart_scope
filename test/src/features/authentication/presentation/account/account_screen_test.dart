import 'package:cart_scope/src/features/authentication/presentation/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../auth_robot.dart';

void main() {
  testWidgets('Cancel logout', (tester) async {
    AuthRobot r = AuthRobot(tester);
    await r.pumbAccountScreen();
    await r.tapLogOutButton();
    r.expectLogoutDialog();
    await r.tapCanceltButton();
    r.expectLogoutDialogNotFound();
  });

  testWidgets('Confirm logout success', (tester) async {
    AuthRobot r = AuthRobot(tester);
    await r.pumbAccountScreen();
    await r.tapLogOutButton();
    r.expectLogoutDialog();
    await r.tapLogOutAlertButton();
    r.expectLogoutDialogNotFound();
  });
}
