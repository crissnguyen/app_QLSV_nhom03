// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../utils/cache.dart';
import 'base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  /// {@macro auth_repository}
  AuthRepository({CacheClient? cache, auth.FirebaseAuth? firebaseAuth})
      : _cache = cache ?? CacheClient(),
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  final CacheClient _cache;
  final auth.FirebaseAuth _firebaseAuth;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const authUserCacheKey = '__authUser_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  @override
  Stream<auth.User?> get authUser {
    return _firebaseAuth.userChanges().map((firebaseUser) {
      if (firebaseUser != null) {
        _cache.write(key: authUserCacheKey, value: firebaseUser);
      }
      return firebaseUser;
    });
  }

  /// Returns the current cached user.
  @override
  auth.User? get currentauthUser =>
      _cache.read<auth.User>(key: authUserCacheKey);

  /// Signs in with the provided [email] and [password].
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  @override
  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      print('FirebaseAuthException:');
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on auth.FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}');
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs in with the provided [username] and [password].
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  @override
  Future<void> logInWithUserNameAndPassword(
      {required String username, required String password}) async {
    try {
      final snap = await FirebaseFirestore.instance
          .collection("users")
          .where("username", isEqualTo: username)
          .get();
      await logInWithEmailAndPassword(
          email: snap.docs[0]['email'], password: password);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

/// {@template log_in_with_email_and_password_failure}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
/// {@endtemplate}
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'E-mail không đúng định dạng. Xin vui lòng thử lại',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'Người dùng này đã bị vô hiệu hóa. Vui lòng liên hệ hỗ trợ để được giúp đỡ.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'E-mail không tìm thấy. Vui lòng liên hệ hỗ trợ để được giúp đỡ.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Sai mật khẩu. Xin vui lòng thử lại.',
        );
      case 'network-request-failed':
        return const LogInWithEmailAndPasswordFailure(
          'Yêu cầu kết nối mạng không thành công. Xin vui lòng kiểm tra kết nối mạng',
        );
      case 'too-many-requests':
        return const LogInWithEmailAndPasswordFailure(
          'Có quá nhiều yêu cầu đăng nhập. Vui lòng kiểm tra thông tin đăng nhập trước đó.',
        );
      case 'account-exists-with-different-credential':
        return const LogInWithEmailAndPasswordFailure(
          'Tài khoản tồn tại với thông tin xác thực khác nhau. Vui lòng kiểm tra thông tin đăng nhập trước đó.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}
