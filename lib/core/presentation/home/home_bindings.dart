import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/home/home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() => Get.lazyPut(
        () => HomeController(),
      );
}
