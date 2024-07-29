import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/Routes/router.dart';
import 'package:identity_engine/core/presentation/widget/widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AuthController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  RxBool isAuthenticated = false.obs;
  RxBool isConnected = false.obs;
  RxBool isCheckingConnection = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    isCheckingConnection.value = true;
    await Future.delayed(
      const Duration(seconds: 3),
    );
    var connectivityResult = await (Connectivity().checkConnectivity());
    isCheckingConnection.value = false;
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      isConnected.value = true;
      authenticate();
    } else {
      isConnected.value = false;
    }
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
      } else {
        // Si el dispositivo no soporta autenticación biométrica, continuar sin autenticación
        isAuthenticated.value = true;
      }
    } catch (e) {
      print(e);
      // Si ocurre un error, permitir el acceso
      isAuthenticated.value = true;
    }

    // Después de completar la autenticación, navegar a la siguiente pantalla
    if (isAuthenticated.value) {
      Get.offNamed(Routes.home);
    }
  }

    void showCheckingConnectionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // No se puede cerrar el diálogo tocando fuera de él
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.black54,
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text(
                'Verificando conexión...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }

  void showNoConnectionDialog(BuildContext context) {
    Get.dialog(
      barrierDismissible: false,
      CustomDialogLostConection(),
    );
  }
}
