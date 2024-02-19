import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends Notifier<AsyncValue<void>> {
  late FakeAuthRepository fakeAuthRepository;

  @override
  AsyncValue<void> build() {
    fakeAuthRepository = ref.watch(authRepositoryProvider);
    return const AsyncValue.data(null);
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    try {
      await fakeAuthRepository.signOut();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final accountScreenControllerProvider =
    NotifierProvider<AccountScreenController, AsyncValue<void>>(() {
  return AccountScreenController();
});
