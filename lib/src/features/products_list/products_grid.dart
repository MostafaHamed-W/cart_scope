import 'dart:math';
import 'package:cart_scope/src/features/product_page/product_screen.dart';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:cart_scope/src/models/product.dart';
import 'package:cart_scope/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:cart_scope/src/constants/app_sizes.dart';
import 'package:cart_scope/src/features/products_list/product_card.dart';
import 'package:cart_scope/src/localization/language_constants';
import 'package:go_router/go_router.dart';

/// A widget that displays the list of products that match the search query.
class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Read from data source
    var products = [
      Product(
        id: '1',
        imageUrl: 'assets/products/bruschetta-plate.jpg',
        title: tr(context).bruschettaPlate,
        description: 'Lorem ipsum',
        price: 15,
        availableQuantity: 5,
        avgRating: 4.5,
        numRatings: 2,
      ),
      Product(
        id: '2',
        imageUrl: 'assets/products/mozzarella-plate.jpg',
        title: 'Mozzarella plate',
        description: 'Lorem ipsum',
        price: 13,
        availableQuantity: 5,
        avgRating: 4,
        numRatings: 2,
      ),
      Product(
        id: '3',
        imageUrl: 'assets/products/pasta-plate.jpg',
        title: 'Pasta plate',
        description: 'Lorem ipsum',
        price: 17,
        availableQuantity: 5,
        avgRating: 5,
        numRatings: 2,
      ),
      Product(
        id: '4',
        imageUrl: 'assets/products/piggy-blue.jpg',
        title: 'Piggy Bank Blue',
        description: 'Lorem ipsum',
        price: 12,
        availableQuantity: 5,
      ),
      Product(
        id: '5',
        imageUrl: 'assets/products/piggy-green.jpg',
        title: 'Piggy Bank Green',
        description: 'Lorem ipsum',
        price: 12,
        availableQuantity: 10,
      ),
      Product(
        id: '6',
        imageUrl: 'assets/products/piggy-pink.jpg',
        title: 'Piggy Bank Pink',
        description: 'Lorem ipsum',
        price: 12,
        availableQuantity: 10,
      ),
      Product(
        id: '7',
        imageUrl: 'assets/products/pizza-plate.jpg',
        title: 'Pizza plate',
        description: 'Lorem ipsum',
        price: 18,
        availableQuantity: 10,
      ),
      Product(
        id: '8',
        imageUrl: 'assets/products/plate-and-bowl.jpg',
        title: 'Plate and Bowl',
        description: 'Lorem ipsum',
        price: 21,
        availableQuantity: 10,
      ),
      Product(
        id: '9',
        imageUrl: 'assets/products/salt-pepper-lemon.jpg',
        title: 'Salt and pepper lemon',
        description: 'Lorem ipsum',
        price: 11,
        availableQuantity: 10,
      ),
      Product(
        id: '10',
        imageUrl: 'assets/products/salt-pepper-olives.jpg',
        title: 'Salt and pepper olives',
        description: 'Lorem ipsum',
        price: 11,
        availableQuantity: 10,
      ),
      Product(
        id: '11',
        imageUrl: 'assets/products/snacks-plate.jpg',
        title: 'Snacks plate',
        description: 'Lorem ipsum',
        price: 24,
        availableQuantity: 10,
      ),
      Product(
        id: '12',
        imageUrl: 'assets/products/flowers-plate.jpg',
        title: 'Flowers plate',
        description: 'Lorem ipsum',
        price: 22,
        availableQuantity: 10,
      ),
      Product(
        id: '13',
        imageUrl: 'assets/products/juicer-citrus-fruits.jpg',
        title: 'Juicer for citrus fruits',
        description: 'Lorem ipsum',
        price: 14,
        availableQuantity: 10,
      ),
      Product(
        id: '14',
        imageUrl: 'assets/products/honey-pot.jpg',
        title: 'Honey pot',
        description: 'Lorem ipsum',
        price: 16,
        availableQuantity: 10,
      ),
    ];

    return products.isEmpty
        ? Center(
            child: Text(
              'No products found'.hardcoded,
              style: Theme.of(context).textTheme.headline4,
            ),
          )
        : ProductsLayoutGrid(
            itemCount: products.length,
            itemBuilder: (_, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onPressed: () =>
                    context.goNamed(AppRoute.product.name, pathParameters: {'id': product.id}),
              );
            },
          );
  }
}

/// Grid widget with content-sized items.
/// See: https://codewithandrea.com/articles/flutter-layout-grid-content-sized-items/
class ProductsLayoutGrid extends StatelessWidget {
  const ProductsLayoutGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  /// Total number of items to display.
  final int itemCount;

  /// Function used to build a widget for a given index in the grid.
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    // use a LayoutBuilder to determine the crossAxisCount
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      // 1 column for width < 500px
      // then add one more column for each 250px
      final crossAxisCount = max(1, width ~/ 250);
      // once the crossAxisCount is known, calculate the column and row sizes
      // set some flexible track sizes based on the crossAxisCount with 1.fr
      final columnSizes = List.generate(crossAxisCount, (_) => 1.fr);
      final numRows = (itemCount / crossAxisCount).ceil();
      // set all the row sizes to auto (self-sizing height)
      final rowSizes = List.generate(numRows, (_) => auto);
      // Custom layout grid. See: https://pub.dev/packages/flutter_layout_grid
      return LayoutGrid(
        columnSizes: columnSizes,
        rowSizes: rowSizes,
        rowGap: Sizes.p24, // equivalent to mainAxisSpacing
        columnGap: Sizes.p24, // equivalent to crossAxisSpacing
        children: [
          // render all the items with automatic child placement
          for (var i = 0; i < itemCount; i++) itemBuilder(context, i),
        ],
      );
    });
  }
}
