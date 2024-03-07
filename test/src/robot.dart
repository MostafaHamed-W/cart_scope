import 'package:cart_scope/src/app.dart';
import 'package:cart_scope/src/constants/test_products.dart';
import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/products/data/fake_product_repository.dart';
import 'package:cart_scope/src/features/products/presentation/home_app_bar/more_menu_button.dart';
import 'package:cart_scope/src/features/products/presentation/products_list/product_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'features/authentication/auth_robot.dart';
import 'goldens/golden_robot.dart';

class Robot {
  Robot(this.tester)
      : auth = AuthRobot(tester),
        golden = GoldenRobot(tester);
  WidgetTester tester;
  final AuthRobot auth;
  final GoldenRobot golden;

  Future<void> pumpMyApp() async {
    // Override repositories
    final productsRepository = FakeProductRepository(isDelayed: false);
    final authRepository = FakeAuthRepository(isDelayed: false);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          productRepositoryProvider.overrideWithValue(productsRepository),
          authRepositoryProvider.overrideWithValue(authRepository),
        ],
        child: const CartScope(),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> findAppBarText() async {
    final text = find.text('My Shop');
    expect(text, findsWidgets);
  }

  Future<void> expectFindAllProductCards() async {
    final finder = find.byType(ProductCard);
    expect(finder, findsNWidgets(kTestProducts.length));
  }

  // To open pop up menu if the app is in minimized width
  Future<void> openPopUpMenu() async {
    final finder = find.byType(MoreMenuButton);
    final matches = finder.evaluate();
    // if the item found it means theat
    // we are running in small windows
    // and the menu will pop down
    if (matches.isNotEmpty) {
      await tester.tap(finder);
      await tester.pumpAndSettle();
    }
  }
  // We need a method to open the signin page, but we will implement it in auth robot
}
