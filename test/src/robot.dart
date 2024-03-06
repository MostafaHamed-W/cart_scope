import 'package:cart_scope/src/app.dart';
import 'package:cart_scope/src/constants/test_products.dart';
import 'package:cart_scope/src/features/products/presentation/products_list/product_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class Robot {
  WidgetTester tester;
  Robot(this.tester);

  Future<void> pumpAppScreen() async {
    await tester.pumpWidget(
      const ProviderScope(
        child: CartScope(),
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
}
