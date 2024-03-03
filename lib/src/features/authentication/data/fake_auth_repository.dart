// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cart_scope/src/features/authentication/domain/app_user.dart';
import 'package:cart_scope/src/localization/string_hardcoded.dart';
import 'package:cart_scope/src/utils/delay.dart';
import 'package:cart_scope/src/utils/in_memory_store.dart';

abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();
  AppUser? get currentUser;
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createEmailWithEmailAndPassword(String emial, String password);
  Future<void> signOut();
}

class FakeAuthRepository implements AuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);
  final bool isDelayed;
  FakeAuthRepository({
    this.isDelayed = true,
  });

  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;

  @override
  AppUser? get currentUser => _authState.value;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await delay(isDelayed);
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  @override
  Future<void> createEmailWithEmailAndPassword(String email, String password) async {
    await delay(isDelayed);
    if (currentUser == null) {
      _createNewUser(email);
    }
  }

  @override
  Future<void> signOut() async {
    await delay(isDelayed);
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
