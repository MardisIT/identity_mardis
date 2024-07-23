import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/Authentication/auth_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() => Get.lazyPut(
        () => AuthController(),
      );
}