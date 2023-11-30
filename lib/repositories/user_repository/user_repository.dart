// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../models/user_model/user_model.dart';
import '../../utils/cache.dart';
import 'base_user_repository.dart';

class UserRepository extends BaseUserRepository {
  UserRepository({
    CacheClient? cache,
    FirebaseFirestore? firebaseFirestore,
  })  : _cache = cache ?? CacheClient(),
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final CacheClient _cache;
  final FirebaseFirestore _firebaseFirestore;

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  @override
  Future<UserModel> getUser(String userId) async {
    print('Getting user data from Cloud Firestore');

    final userDoc =
        await _firebaseFirestore.collection('users').doc(userId).get();

    print("userDoc ${userDoc.data()}");

    if (userDoc.exists) {
      final userModel = UserModel.fromMap(userDoc.data()!);
      _cache.write(key: userCacheKey, value: userModel);
      return userModel;
    } else {
      return UserModel.empty;
    }
  }

  @override
  UserModel get currentUser =>
      _cache.read<UserModel>(key: userCacheKey) ?? UserModel.empty;

  @override
  Future<void> updateUser(UserModel user) async {
    return _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .update(user.toMap())
        .then(
          (value) => print('User document updated.'),
        )
        .catchError((error) => print("Failed to update user document: $error"));
  }
}
