import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreenController extends StateNotifier<EmailPasswordSignInState> {
  SignInScreenController(
      {required EmailPasswordSignInFormType formType, required this.fakeAuthRepository})
      : super(EmailPasswordSignInState(formType: formType));

  final FakeAuthRepository fakeAuthRepository;

  Future<bool> submit(String email, String password) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value = await AsyncValue.guard(() => _authinticate(email, password));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }

  Future<void> _authinticate(String email, String password) async {
    switch (state.formType) {
      case EmailPasswordSignInFormType.signIn:
        fakeAuthRepository.signInWithEmailAndPassword(email, password);
      case EmailPasswordSignInFormType.register:
        fakeAuthRepository.createEmailWithEmailAndPassword(email, password);
    }
  }
}

final signInScreenController = StateNotifierProvider.family<SignInScreenController,
    EmailPasswordSignInState, EmailPasswordSignInFormType>((ref, formType) {
  final fakeAuthRepository = ref.watch(authRepositoryProvider);
  return SignInScreenController(formType: formType, fakeAuthRepository: fakeAuthRepository);
});
