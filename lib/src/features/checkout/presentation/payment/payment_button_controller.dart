import 'package:cart_scope/src/features/checkout/application/fake_checkout_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentButtonController extends StateNotifier<AsyncValue<void>> {
  PaymentButtonController({required this.checkoutService}) : super(const AsyncData(null));
  final FakeCheckoutService checkoutService;

  Future<void> pay() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(checkoutService.placeOrder);
  }
}

final paymentButtonControllerProvider =
    StateNotifierProvider.autoDispose<PaymentButtonController, AsyncValue<void>>((ref) {
  return PaymentButtonController(checkoutService: ref.watch(checkoutServiceProvider));
});
