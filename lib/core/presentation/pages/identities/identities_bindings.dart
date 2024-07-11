import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';

class IdentitiesBindings extends Bindings {
  @override
  void dependencies() => Get.lazyPut(
        () => IdentitiesController(),
      );
}
