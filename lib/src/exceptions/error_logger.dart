import 'dart:developer';

import 'package:cart_scope/src/exceptions/app_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorLogger {
  void logError(Object error, StackTrace? stackTrace) {
    // * This can be replaced with a call to crash reporting tool of choice
    log('$error, $stackTrace');
  }

  void logAppException(AppException exception) {
    // * This can be replaced with a call to crash reporting tool of choice
    log('$exception');
  }
}

final errorLoggerProvider = Provider<ErrorLogger>((ref) {
  return ErrorLogger();
});
