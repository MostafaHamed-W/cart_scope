import 'package:cart_scope/src/common_widgets/async_value_widget.dart';
import 'package:cart_scope/src/features/cart/application/cart_service.dart';
import 'package:cart_scope/src/features/cart/domain/cart.dart';
import 'package:cart_scope/src/features/cart/presentation/shopping_cart/shopping_cart_item.dart';
import 'package:cart_scope/src/features/cart/presentation/shopping_cart/shopping_cart_items_builder.dart';
import 'package:cart_scope/src/features/checkout/presentation/payment/payment_button.dart';
import 'package:cart_scope/src/features/cart/domain/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Payment screen showing the items in the cart (with read-only quantities) and
/// a button to checkout.
class PaymentPage extends ConsumerWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  Listen to cart changes on checkout and update the UI.
    //  Read from data source
    final cartValue = ref.read(cartProvider);

    return AsyncValueWidget<Cart>(
      value: cartValue,
      data: (cart) {
        return ShoppingCartItemsBuilder(
          items: cart.toItemsList(),
          itemBuilder: (_, item, index) => ShoppingCartItem(
            item: item,
            itemIndex: index,
            isEditable: false,
          ),
          ctaBuilder: (_) => const PaymentButton(),
        );
      },
    );
  }
}
