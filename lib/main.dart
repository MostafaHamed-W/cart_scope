import 'dart:async';

import 'package:cart_scope/src/app.dart';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

void main() async {
  // * For more info on error handling, see:
  // * https://docs.flutter.dev/testing/errors

  // turn off the # in the URLs on the web
  usePathUrlStrategy();

  // to make pushNamed or push effects the url we do this afer V8.0.0
  GoRouter.optionURLReflectsImperativeAPIs = true;

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // * Entry point of the app
      runApp(const CartScope());

      // * This code will present some error UI if any uncaught exception happens
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
      };
      ErrorWidget.builder = (FlutterErrorDetails details) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text('An error occurred'.hardcoded),
          ),
          body: Center(child: Text(details.toString())),
        );
      };
    },
    (Object error, StackTrace stack) {
      // * Log any errors to console
      debugPrint(error.toString());
    },
  );
}
