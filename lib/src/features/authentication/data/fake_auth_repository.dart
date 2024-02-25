import 'package:cart_scope/src/features/authentication/domain/app_user.dart';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:cart_scope/src/utils/delay.dart';
import 'package:cart_scope/src/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();
  AppUser? get currentUser;
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createEmailWithEmailAndPassword(String emial, String password);
  Future<void> signOut();
}

class FakeAuthRepository implements AuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);

  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;

  @override
  AppUser? get currentUser => _authState.value;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  @override
  Future<void> createEmailWithEmailAndPassword(String email, String password) async {
    await delay(true);
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  @override
  Future<void> signOut() async {
    await delay(true);
    // throw Exception('Error signning in!');
    _authState.value = null;
  }

  void dispose() => _authState.close();

  void _createNewUser(String email) {
    _authState.value = AppUser(
      uid: email.split('').reversed.join(),
      email: email,
    );
  }
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  // final isFake = String.fromEnvironment("useFakeRepos") == true;
  // return isFake ? FakeAuthRepository() : FirebaseAuthRepository();
  final auth = FakeAuthRepository();
  ref.onDispose(() {
    auth.dispose();
  });
  return auth;
});

final authStateChangesProvider = StreamProvider<AppUser?>((ref) {
  final authRepsitoryProvider = ref.watch(authRepositoryProvider);
  return authRepsitoryProvider.authStateChanges();
});
