import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../robot.dart';

void main() {
  testWidgets(
    'auth flow test',
    (tester) async {
      // Mock network images
      mockNetworkImagesFor(() async {
        final r = Robot(tester);
        await r.pumpAppScreen();
        await r.expectFindAllProductCards();
        await r.openPopUpMenu();
        await r.auth.openEmailAndPasswordSigninScreen();
        await r.auth.signIntWithEmailAndPasswordScreen('wafy@gmail.com', '1234');
        await r.openPopUpMenu();
        await r.auth.openAccountSreen();
        expect(find.text('uid'), findsOneWidget);
        await r.openPopUpMenu();
        await r.auth.tapLogoutButton();
        await r.auth.tapDialogLogoutButton();
        await r.expectFindAllProductCards();
      });
    },
  );
}
