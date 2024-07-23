import 'package:get/get.dart';
import 'package:identity_engine/core/Routes/router.dart';
import 'package:local_auth/local_auth.dart';

class AuthController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  RxBool isAuthenticated = false.obs;

  @override
  void onInit() async {
    authenticate();
    super.onInit();
  }

  Future<void> authenticate() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isDeviceSupported = await auth.isDeviceSupported();

      if (canCheckBiometrics && isDeviceSupported) {
        isAuthenticated.value = await auth.authenticate(
          localizedReason: 'Please authenticate to access this feature',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
      }
      if (isAuthenticated.value) {
        Get.offNamed(Routes.home);
      } else {
        // Si el dispositivo no soporta autenticación biométrica, continuar sin autenticación
        isAuthenticated.value = true;
      }
    } catch (e) {
      print(e);
    }
  }
}
