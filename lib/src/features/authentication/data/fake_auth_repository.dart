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