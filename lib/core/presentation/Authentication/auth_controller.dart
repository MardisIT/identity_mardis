import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/Routes/router.dart';
import 'package:identity_engine/core/presentation/widget/widgets.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
    authenticate();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> checkConnectivity() async {
    isCheckingConnection.value = true;
    showCheckingConnectionDialog();
    await Future.delayed(
      const Duration(seconds: 3),
    );
    var connectivityResult = await (Connectivity().checkConnectivity());
    isCheckingConnection.value = false;
    Get.back();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      isConnected.value = true;
      Get.offNamed(Routes.home);
    } else {
      isConnected.value = false;
      showNoConnectionDialog();
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
      // checkConnectivity();
      getConnectivity();
    }
  }

  Future<void> showCheckingConnectionDialog() async {
    if (Get.isDialogOpen == false) {
      Get.dialog(
        barrierDismissible: false,
        const AlertDialog(
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
        ),
      );
    }
  }

  Future<void> showNoConnectionDialog() async {
    // if (Get.isDialogOpen == false) {
      Get.dialog(
        barrierDismissible: false,
        CustomDialogLostConection(
          onRetry: () async {
            Get.back(); // Cierra el diálogo
            await checkInternetAndNavigate();
          },
        ),
      );
    // }
  }

  //! NEW CONNECTION METHOD

  late StreamSubscription subscription;
  var isDeviceConnected = false.obs;
  RxBool isAlertSet = false.obs;

  Future<void> checkInternetAndNavigate() async {
    showCheckingConnectionDialog();
    isDeviceConnected.value =
        await InternetConnectionChecker.createInstance().hasConnection;
    if (isDeviceConnected.value) {
      Get.back(); // Cierra el diálogo de verificación
      Get.offNamed(Routes.home);
    } else {
      Get.back(); // Cierra el diálogo de verificación
      showNoConnectionDialog();
    }
  }

  void getConnectivity() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> result) async {
        await checkInternetAndNavigate();
      },
    );
  }
}
