import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/pages/configuration/configuration_controller.dart';

class ConfigurationBindings extends Bindings {
  @override
  void dependencies() => Get.lazyPut(
        () => ConfigurationController(),
      );
}
