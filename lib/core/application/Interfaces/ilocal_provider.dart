import 'package:identity_engine/core/domain/Models/Global/user.dart';

abstract class ILocalProvider {
  Future<User> getUser();
  Future<String?> getToken();
  Future<void> clearAllData();
  Future<String?> saveToken({required String token});
}
