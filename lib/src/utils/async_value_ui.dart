import 'package:cart_scope/src/common_widgets/alert_dialogs.dart';
import 'package:cart_scope/src/exceptions/app_exception.dart';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      final message = _getErrorMessage(error);
      showExceptionAlertDialog(
        context: context,
        title: 'Error'.hardcoded,
        exception: message,
      );
    }
  }

  String _getErrorMessage(Object? error) {
    if (error is AppException) {
      return error.details.message;
    } else {
      return error.toString();
    }
  }
}
