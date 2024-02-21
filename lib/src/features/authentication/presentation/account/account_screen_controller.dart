import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreenController extends Notifier<AsyncValue<void>> {
  late FakeAuthRepository fakeAuthRepository;

  @override
  AsyncValue<void> build() {
    fakeAuthRepository = ref.watch(authRepositoryProvider);
    return const AsyncValue.data(null);
  }

  Future<bool> signOut() async {
    // state = const AsyncValue.loading();
    // await Future.delayed(const Duration(seconds: 2));
    // try {
    //   await fakeAuthRepository.signOut();
    //   state = const AsyncValue<void>.data(null);
    //   return true;
    // } catch (e, st) {
    //   state = AsyncValue<void>.error(e, st);
    //   return false;
    // }

    //Instead of using try, catch and write boiler plate code, riverpod has created us .Gurad
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    state = await AsyncValue.guard(() => fakeAuthRepository.signOut());
    // print(state.hasError);
    return state.hasError == false;
  }
}

final accountScreenControllerProvider =
    NotifierProvider<AccountScreenController, AsyncValue<void>>(() {
  return AccountScreenController();
});
