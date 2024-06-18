import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

@freezed
class AppException with _$AppException {
  // Auth
  const factory AppException.emailAlreadyInUse() = EmailAlreadyInUse;
  const factory AppException.weakPassword() = WeakPassword;
  const factory AppException.wrongPassword() = WrongPassword;
  const factory AppException.userNotFound() = UserNotFound;
  // Cart
  const factory AppException.cartSyncFailed() = CartSyncFailed;
  // Checkout
  const factory AppException.paymentFailureEmptyCart() = PaymentFailureEmptyCart;
  // Orders
  const factory AppException.parseOrderFailure(String status) = ParseOrderFailure;
}
