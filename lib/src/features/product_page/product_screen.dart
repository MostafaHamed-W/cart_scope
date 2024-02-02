import 'package:cart_scope/src/app.dart';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:cart_scope/src/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:cart_scope/src/common_widgets/custom_image.dart';
import 'package:cart_scope/src/common_widgets/responsive_center.dart';
import 'package:cart_scope/src/common_widgets/responsive_two_column_layout.dart';
import 'package:cart_scope/src/constants/app_sizes.dart';
import 'package:cart_scope/src/features/home_app_bar/home_app_bar.dart';
import 'package:cart_scope/src/features/not_found/empty_placeholder_widget.dart';
import 'package:cart_scope/src/features/product_page/add_to_cart/add_to_cart_widget.dart';
import 'package:cart_scope/src/features/product_page/leave_review_action.dart';
import 'package:cart_scope/src/features/product_page/product_average_rating.dart';
import 'package:cart_scope/src/features/product_page/product_reviews/product_reviews_list.dart';
import 'package:cart_scope/src/models/product.dart';
import 'package:cart_scope/src/localization/language_constants';

/// Shows the product page for a given product ID.
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    var kTestProducts = [
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

    final product = kTestProducts.firstWhere((product) => product.id == productId);
    return Scaffold(
      appBar: const HomeAppBar(),
      body: product == null
          ? EmptyPlaceholderWidget(
              message: 'Product not found'.hardcoded,
            )
          : CustomScrollView(
              slivers: [
                ResponsiveSliverCenter(
                  padding: const EdgeInsets.all(Sizes.p16),
                  child: ProductDetails(product: product),
                ),
                ProductReviewsList(productId: productId),
              ],
            ),
    );
  }
}

/// Shows all the product details along with actions to:
/// - leave a review
/// - add to cart
class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final priceFormatted = kCurrencyFormatter.format(product.price);
    return ResponsiveTwoColumnLayout(
      startContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: CustomImage(imageUrl: product.imageUrl),
        ),
      ),
      spacing: Sizes.p16,
      endContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(product.title, style: Theme.of(context).textTheme.headline6),
              gapH8,
              Text(product.description),
              // Only show average if there is at least one rating
              if (product.numRatings >= 1) ...[
                gapH8,
                ProductAverageRating(product: product),
              ],
              gapH8,
              const Divider(),
              gapH8,
              Text(priceFormatted, style: Theme.of(context).textTheme.headline5),
              gapH8,
              LeaveReviewAction(productId: product.id),
              const Divider(),
              gapH8,
              AddToCartWidget(product: product),
            ],
          ),
        ),
      ),
    );
  }
}
