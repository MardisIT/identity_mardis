import 'package:identity_engine/core/domain/Models/Global/user.dart';
import 'package:identity_engine/core/domain/Models/login/user_view_model.dart';

abstract class ILocalProvider {
  Future<User> getUser();
  Future<String?> getToken();
  Future<void> clearAllData();
  Future<UserViewModel> saveUser(UserViewModel user);
  Future<String?> saveToken({required String token});
}
