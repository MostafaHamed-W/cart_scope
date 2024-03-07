import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:integration_test/integration_test.dart';
import '../test/src/robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets(
    'auth flow test',
    (tester) async {
      // Mock network images
      await mockNetworkImagesFor(() async {
        final r = Robot(tester);
        await r.pumpMyApp();
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
