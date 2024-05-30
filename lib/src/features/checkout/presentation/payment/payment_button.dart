import 'package:cart_scope/src/features/checkout/presentation/payment/payment_button_controller.dart';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:cart_scope/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:cart_scope/src/common_widgets/primary_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Button used to initiate the payment flow.
class PaymentButton extends ConsumerWidget {
  const PaymentButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Error handling
    ref.listen<AsyncValue>(paymentButtonControllerProvider, (_, state) => state.showAlertDialogOnError(context));
    // Loading state
    final state = ref.read(paymentButtonControllerProvider);
    return PrimaryButton(
      text: 'Pay'.hardcoded,
      isLoading: state.isLoading,
      onPressed: () => state.isLoading ? null : ref.read(paymentButtonControllerProvider.notifier).pay(),
    );
  }
}
