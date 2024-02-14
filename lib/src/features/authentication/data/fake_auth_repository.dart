import 'package:cart_scope/src/features/authentication/domain/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeAuthRepository {
  Stream<AppUser?> authStateChanges() => Stream.value(null); //TODO: implement

  AppUser? get currentUser => null; //TODO: implement

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    //TODO: implement
  }

  Future<void> createEmailWithEmailAndPassword(String emial, String password) async {
    //TODO: implement
  }

  Future<void> signOut() async {
    //TODO: implement
  }
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  return FakeAuthRepository();
});

final authStateChangesProvider = StreamProvider<AppUser?>((ref) {
  final authRepsitoryProvider = ref.watch(authRepositoryProvider);
  return authRepsitoryProvider.authStateChanges();
});
