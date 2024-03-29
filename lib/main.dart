import 'dart:ui';
import 'package:cart_scope/src/app.dart';
import 'package:cart_scope/src/features/cart/data/local/local_cart_repository.dart';
import 'package:cart_scope/src/features/cart/data/local/sembast_cart_rebository.dart';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // turn off the # in the URLs on the web
  // usePathUrlStrategy();
  // * Register error handlers. For more info, see:dart format .
  // * https://docs.flutter.dev/testing/errors
  registerErrorHandlers();
  // * Entry point of the app

  // Override local cart provider before run app
  final localCartRepository = await SembastCartRepository.makeDefault();

  runApp(
    ProviderScope(
      overrides: [
        localCartRepositoryProvider.overrideWithValue(localCartRepository),
      ],
      child: const CartScope(),
    ),
  );
  // *to make pushNamed or push effects the url we do this afer V8.0.0
  // GoRouter.optionURLReflectsImperativeAPIs = true;
}

void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('An error occurred'.hardcoded),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
