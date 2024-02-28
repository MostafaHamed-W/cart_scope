import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailPasswordSignInController extends StateNotifier<EmailPasswordSignInState> {
  EmailPasswordSignInController(
      {required EmailPasswordSignInFormType formType, required this.fakeAuthRepository})
      : super(EmailPasswordSignInState(formType: formType));

  final FakeAuthRepository fakeAuthRepository;

  // We devide sign in into two methods as refactoring
  Future<bool> submit(String email, String password) async {
    state = state.copyWith(value: const AsyncValue.loading());
    // await Future.delayed(const Duration(seconds: 2));
    final value = await AsyncValue.guard(() => _authinticate(email, password));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }

  Future<void> _authinticate(String email, String password) async {
    switch (state.formType) {
      case EmailPasswordSignInFormType.signIn:
        return fakeAuthRepository.signInWithEmailAndPassword(email, password);
      case EmailPasswordSignInFormType.register:
        return fakeAuthRepository.createEmailWithEmailAndPassword(email, password);
    }
  }

  void updateFormType(EmailPasswordSignInFormType formType) {
    state = state.copyWith(
      formType: formType,
      // To avoid alert dialog show up wueh form type update after an error of logging in
      // because the value was set to AsyncValue.error() and never changed
      // value: const AsyncValue.data(null),

      // Another solution we can add .select() to the listener of alert error dialog
      // to only listen to the asyncValue and never called when the formType changed
    );
  }
}

final signInScreenControllerProvider = StateNotifierProvider.autoDispose
    .family<EmailPasswordSignInController, EmailPasswordSignInState, EmailPasswordSignInFormType>(
        (ref, formType) {
  final fakeAuthRepository = ref.watch(authRepositoryProvider);
  return EmailPasswordSignInController(formType: formType, fakeAuthRepository: fakeAuthRepository);
});
