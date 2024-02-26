import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FakeAuthRepository makeAuthRepository() => FakeAuthRepository(isDelayed: false);

  String testEmail = 'wafy@gmail.com';
  String testPassword = '12345678';
  String testUid = testEmail.split('').reversed.join();
  AppUser testUser = AppUser(uid: testUid, email: testEmail);

  group(
    'Test FakeAuthRepository',
    () {
      test('test currentUser with null return', () {
        final fakeAuthRepository = makeAuthRepository();
        expect(fakeAuthRepository.currentUser, null);
        expect(fakeAuthRepository.authStateChanges(), emits(null));
      });

      test('Test FakeAuthRepository after signin', () async {
        final fakeAuthRepository = makeAuthRepository();
        await fakeAuthRepository.signInWithEmailAndPassword(testEmail, testPassword);
        expect(fakeAuthRepository.currentUser, testUser);
        expect(fakeAuthRepository.authStateChanges(), emits(testUser));
      });

      test(
        'Test FakeAuthRepository after signup',
        () async {
          final fakeAuthRepository = makeAuthRepository();
          await fakeAuthRepository.createEmailWithEmailAndPassword(testEmail, testPassword);
          expect(fakeAuthRepository.currentUser, testUser);
          expect(fakeAuthRepository.authStateChanges(), emits(testUser));
        },
      );

      test(
        'Current user is null after sign out',
        () async {
          final fakeAuthRepository = makeAuthRepository();
          await fakeAuthRepository.signInWithEmailAndPassword(testEmail, testPassword);
          expect(fakeAuthRepository.currentUser, testUser);
          expect(fakeAuthRepository.authStateChanges(), emits(testUser));
          await fakeAuthRepository.signOut();
          expect(fakeAuthRepository.currentUser, null);
          expect(fakeAuthRepository.authStateChanges(), emits(null));
        },
      );

      test(
        'Sign in method after dispose throw an exception',
        () async {
          final fakeAuthRepository = makeAuthRepository();
          fakeAuthRepository.dispose();
          expect(
            () => fakeAuthRepository.signInWithEmailAndPassword(testEmail, testPassword),
            throwsStateError,
          );
        },
      );
    },
  );
}
