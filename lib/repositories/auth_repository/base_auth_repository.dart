import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
  Stream<auth.User?> get authUser;
  auth.User? get currentauthUser;

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> logInWithUserNameAndPassword({
    required String username,
    required String password,
  });
  Future<void> logOut();
}
