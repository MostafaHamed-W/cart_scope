import 'package:cart_scope/src/constants/test_products.dart';
import 'package:cart_scope/src/features/products/data/fake_product_repository.dart';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:cart_scope/src/common_widgets/custom_image.dart';
import 'package:cart_scope/src/constants/app_sizes.dart';
import 'package:cart_scope/src/features/cart/domain/item.dart';

/// Shows an individual order item, including price and quantity.
class OrderItemListTile extends StatelessWidget {
  const OrderItemListTile({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    // TODO: Read from data source
    final product = FakeProductRepository.instance.getProduct(item.productId);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: CustomImage(imageUrl: product!.imageUrl),
          ),
          gapW8,
          Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product!.title),
                gapH12,
                Text(
                  'Quantity: ${item.quantity}'.hardcoded,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
