import 'dart:developer';

import 'package:cart_scope/src/exceptions/app_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_logger.g.dart';

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

@riverpod
ErrorLogger errorLogger(ErrorLoggerRef ref) {
  return ErrorLogger();
}
