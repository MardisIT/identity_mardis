import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:identity_engine/Utils/Constants/constants.dart';

import 'package:identity_engine/core/application/Interfaces/ilocal_provider.dart';
import 'package:identity_engine/core/domain/Models/Global/user.dart';
import 'package:identity_engine/core/domain/Models/login/user_view_model.dart';

class LocalProvider extends ILocalProvider {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Future<String?> getToken() {
    // TODO: implement getToken
    throw UnimplementedError();
  }

  @override
  Future<User> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> clearAllData() {
    // TODO: implement clearAllData
    throw UnimplementedError();
  }

  @override
  Future<String?> saveToken({required String token}) async {
    await secureStorage.write(key: csPrefToken, value: token);
    return token;
  }

  @override
  Future<UserViewModel> saveUser(UserViewModel user) async {
    await secureStorage.write(key: csPrefToken, value: user.toRawJson());
    return user;
  }
}
