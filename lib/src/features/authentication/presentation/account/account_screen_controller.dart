import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController(this.fakeAuthRepository) : super(const AsyncValue<void>.data(null));

  final FakeAuthRepository fakeAuthRepository;
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
    StateNotifierProvider<AccountScreenController, AsyncValue<void>>((ref) {
  final fakeAuthRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(fakeAuthRepository);
});
