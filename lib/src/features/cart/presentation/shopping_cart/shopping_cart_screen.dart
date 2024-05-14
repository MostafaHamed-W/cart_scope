import 'package:cart_scope/src/common_widgets/async_value_widget.dart';
import 'package:cart_scope/src/features/cart/application/cart_service.dart';
import 'package:cart_scope/src/features/cart/domain/cart.dart';
import 'package:cart_scope/src/features/cart/presentation/shopping_cart/shopping_cart_item.dart';
import 'package:cart_scope/src/features/cart/presentation/shopping_cart/shopping_cart_items_builder.dart';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:cart_scope/src/features/cart/domain/item.dart';
import 'package:cart_scope/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:cart_scope/src/common_widgets/primary_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Shopping cart screen showing the items in the cart (with editable
/// quantities) and a button to checkout.
class ShoppingCartScreen extends ConsumerWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: error handling
    // TODO: Read from data source
    final cartValue = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'.hardcoded),
      ),
      body: AsyncValueWidget(
        value: cartValue,
        data: (cart) => ShoppingCartItemsBuilder(
          items: cart.toItemsList(),
          itemBuilder: (_, item, index) => ShoppingCartItem(
            item: item,
            itemIndex: index,
          ),
          ctaBuilder: (_) => PrimaryButton(
            text: 'Checkout'.hardcoded,
            onPressed: () => context.pushNamed(AppRoute.checkout.name),
          ),
        ),
      ),
    );
  }
}
