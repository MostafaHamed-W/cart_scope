import 'package:cart_scope/src/features/account/account_screen.dart';
import 'package:cart_scope/src/features/orders_list/orders_list_screen.dart';
import 'package:cart_scope/src/features/products_list/products_list_screen.dart';
import 'package:cart_scope/src/features/shopping_cart/shopping_cart_screen.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  // initialLocation: '/', // it's "/" by default but we can change it
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ProductsListScreen(),
      routes: [
        GoRoute(
          path: 'cart',
          builder: (context, state) => const ShoppingCartScreen(),
        )
      ],
    ),
  ],
);
