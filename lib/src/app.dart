import 'package:cart_scope/src/localization/language_constants';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:cart_scope/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,

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
