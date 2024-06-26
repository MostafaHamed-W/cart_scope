import 'package:cart_scope/src/localization/string_hardcoded.dart';

/// Base class for all all client-side errors that can be generated by the app
class BaseAppException implements Exception {
  BaseAppException(this.code, this.message);
  final String code;
  final String message;
}

/// Auth
class EmailAlreadyInUseException extends BaseAppException {
  EmailAlreadyInUseException() : super('email-already-in-use', 'Email already in use'.hardcoded);
}

class WeakPasswordException extends BaseAppException {
  WeakPasswordException() : super('weak-password', 'Password is too weak'.hardcoded);
}

class WrongPasswordException extends BaseAppException {
  WrongPasswordException() : super('wrong-password', 'Wrong password'.hardcoded);
}

class UserNotFoundException extends BaseAppException {
  UserNotFoundException() : super('user-not-found', 'User not found'.hardcoded);
}

/// Cart
class CartSyncFailedException extends BaseAppException {
  CartSyncFailedException()
      : super('cart-sync-failed', 'An error has occurred while updating the shopping cart'.hardcoded);
}

/// Checkout
class PaymentFailureEmptyCartException extends BaseAppException {
  PaymentFailureEmptyCartException()
      : super('payment-failure-empty-cart', 'Can\'t place an order if the cart is empty'.hardcoded);
}

/// Orders
class ParseOrderFailureException extends BaseAppException {
  ParseOrderFailureException(this.status)
      : super('parse-order-failure', 'Could not parse order status: $status'.hardcoded);
  final String status;
}
