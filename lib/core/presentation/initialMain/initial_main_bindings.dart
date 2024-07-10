import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/initialMain/initial_main_controller.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() => Get.lazyPut(
        () => MainController(
          localProviderInterface: Get.find(),
        ),
      );
}
