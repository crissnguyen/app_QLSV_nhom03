import '../../models/user_model/user_model.dart';

abstract class BaseUserRepository {
  Future<UserModel> getUser(String userId);
  UserModel get currentUser;
  Future<void> updateUser(UserModel user);
}
