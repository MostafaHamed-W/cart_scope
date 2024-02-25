import 'package:cart_scope/src/features/authentication/data/fake_auth_repository.dart';
import 'package:cart_scope/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FakeAuthRepository makeAuthRepository() => FakeAuthRepository();

  String testEmail = 'wafy@gmail.com';
  String testPassword = '12345678';
  String testUid = testEmail.split('').reversed.join();
  AppUser testUser = AppUser(uid: testUid, email: testEmail);

  group('Test FakeAuthRepository', () {
    final fakeAuthRepository = makeAuthRepository();

    test('test currentUser with null return', () {
      expect(fakeAuthRepository.currentUser, null);
      expect(fakeAuthRepository.authStateChanges(), emits(null));
    });
  });

  test('Test FakeAuthRepository with AppUser value', () async {
    final fakeAuthRepository = makeAuthRepository();
    await fakeAuthRepository.signInWithEmailAndPassword(testEmail, testPassword);
    expect(fakeAuthRepository.currentUser, testUser);
    expect(fakeAuthRepository.authStateChanges(), emits(testUser));
  });
}
