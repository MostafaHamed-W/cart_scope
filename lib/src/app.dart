import 'package:cart_scope/src/features/account/account_screen.dart';
import 'package:cart_scope/src/features/orders_list/orders_list_screen.dart';
import 'package:cart_scope/src/features/products_list/products_list_screen.dart';
import 'package:cart_scope/src/localization/language_constants';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class CartScope extends StatefulWidget {
  const CartScope({super.key});

  @override
  State<CartScope> createState() => _CartScopeState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _CartScopeState? state = context.findAncestorStateOfType<_CartScopeState>();
    state?.setLocale(newLocale);
  }
}

class _CartScopeState extends State<CartScope> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => setLocale(locale));
    super.didChangeDependencies();
  }

  final _router = GoRouter(
    initialLocation: '/', // it's "/" by default but we can change it
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsListScreen(),
      ),
      GoRoute(
        path: '/ordersListScreen',
        builder: (context, state) => const OrdersListScreen(),
      ),
      GoRoute(
        path: '/accountScreen',
        builder: (context, state) => const AccountScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      // * The home page of the app
      // home: const ProductsListScreen(),
      onGenerateTitle: (BuildContext context) => 'My Shop'.hardcoded,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // background (button) color
            foregroundColor: Colors.white, // foreground (text) color
          ),
        ),
      ),
    );
  }
}
