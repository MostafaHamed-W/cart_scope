import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AccountScreenController Testing', () {
    test(
      'initial state is AsyncValue.data',
      () async {
        final authReositpry = FakeAuthRepository(isDelayed: false);
        final controller = AccountScreenController(authRepository: authReositpry);
        expect(controller.state, const AsyncData<void>(null));
      },
    );
  });
}
