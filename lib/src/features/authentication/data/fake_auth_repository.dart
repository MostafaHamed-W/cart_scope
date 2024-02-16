import 'package:cart_scope/src/features/authentication/domain/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();
  AppUser? get currentUser;
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> createEmailWithEmailAndPassword(String emial, String password);
  Future<void> signOut();
}

class FakeAuthRepository implements AuthRepository {
  @override
  Stream<AppUser?> authStateChanges() => Stream.value(null); //TODO: implement

  @override
  AppUser? get currentUser => null; //TODO: implement

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    //TODO: implement
  }

  @override
  Future<void> createEmailWithEmailAndPassword(String emial, String password) async {
    //TODO: implement
  }

  @override
  Future<void> signOut() async {
    //TODO: implement
  }
}

class FirebaseAuthRepository implements AuthRepository {
  @override
  Stream<AppUser?> authStateChanges() {
    // TODO: implement authStateChanges
    throw UnimplementedError();
  }

  @override
  Future<void> createEmailWithEmailAndPassword(String emial, String password) {
    // TODO: implement createEmailWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  // TODO: implement currentUser
  AppUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

//we can run with command: —dart-define=useFakeRepos=true to run with string from environment

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  // final isFake = String.fromEnvironment("useFakeRepos") == true;
  // return isFake ? FakeAuthRepository() : FirebaseAuthRepository();
  return FakeAuthRepository();
});

final authStateChangesProvider = StreamProvider<AppUser?>((ref) {
  final authRepsitoryProvider = ref.watch(authRepositoryProvider);
  return authRepsitoryProvider.authStateChanges();
});
