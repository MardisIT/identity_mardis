import 'package:get/get.dart';
import 'package:identity_engine/core/application/Interfaces/ilocal_provider.dart';
import 'package:identity_engine/core/application/Interfaces/ilogin_qr_provider.dart';
import 'package:identity_engine/core/infraestructure/Providers/local_provider.dart';
import 'package:identity_engine/core/infraestructure/Providers/login_provider.dart';

class MainBindingsExt extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ILocalProvider>(() => LocalProvider());
    Get.lazyPut<ILoginProvider>(() => LoginProvider());
  }
}
