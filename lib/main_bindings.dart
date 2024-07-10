import 'package:get/get.dart';
import 'package:identity_engine/core/application/Interfaces/ilocal_provider.dart';
import 'package:identity_engine/core/infraestructure/Providers/local_provider.dart';

class MainBindingsExt extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ILocalProvider>(() => LocalProvider());
  }
}
