import 'dart:async';

import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> signOut() async {
    final authRepository = ref.watch(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signOut());
  }
}

final accountScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<AccountScreenController, void>(AccountScreenController.new);
