import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/Routes/router.dart';
import 'package:identity_engine/core/presentation/widget/widgets.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:local_auth/local_auth.dart';

class AuthController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  RxBool isAuthenticated = false.obs;
  RxBool isConnected = false.obs;
  RxBool isCheckingConnection = true.obs;

  StreamSubscription<InternetConnectionStatus>? connectionSubscription;

  @override
  void onInit() {
    super.onInit();
    authenticate();
  }

  @override
  void onClose() {
    connectionSubscription!.cancel(); // Cancelar el listener
    super.onClose();
  }

  // Future<void> checkConnectivity() async {
  //   isCheckingConnection.value = true;
  //   showCheckingConnectionDialog();

  //   bool hasConnection =
  //       await InternetConnectionChecker.createInstance().hasConnection;
  //   isCheckingConnection.value = false;
  //   Get.back(); // Cierra el diálogo de carga

  //   if (hasConnection) {
  //     isConnected.value = true;
  //   } else {
  //     isConnected.value = false;
  //     showNoConnectionDialog();
  //   }

  //   // Inicia el listener para cambios de conexión
  //   startListeningConnectionChanges();
  // }

  // void startListeningConnectionChanges() {
  //   // Cancela cualquier listener anterior (si lo hay) para evitar duplicados
  //   // connectionSubscription?.cancel();

  //   connectionSubscription = InternetConnectionChecker.createInstance()
  //       .onStatusChange
  //       .listen((status) {
  //     if (status == InternetConnectionStatus.connected) {
  //       if (!isConnected.value) {
  //         isConnected.value = true;
  //         // Get.offNamed(Routes.home); // Solo redirecciona si se desconectó previamente
  //       }
  //     } else if (status == InternetConnectionStatus.disconnected) {
  //       if (isConnected.value) {
  //         isConnected.value = false;
  //         showNoConnectionDialog(); // Muestra el diálogo si pierde conexión
  //       }
  //     }
  //   });
  //   // connectionSubscription?.cancel();
  // }

  void startListeningConnectionChanges() async {
    showCheckingConnectionDialog();
    InternetConnectionStatus initStatus = await InternetConnectionChecker.createInstance().connectionStatus;

    if (initStatus == InternetConnectionStatus.connected) {
      isConnected.value = true;
      Get.back(); // Cierra el diálogo de carga
      Get.offNamed(Routes.home);
    } else {
      isConnected.value = false;
      Get.back(); // Cierra el diálogo de carga
      showNoConnectionDialog();   
    }
    connectionSubscription = InternetConnectionChecker.createInstance()
        .onStatusChange
        .listen((status) {
      if (status == InternetConnectionStatus.connected) {
        if (!isConnected.value) {
          isConnected.value = true;
          // Get.offNamed(Routes.home); // Solo redirecciona si se desconectó previamente
        }
      } else if (status == InternetConnectionStatus.disconnected) {
        if (isConnected.value) {
          isConnected.value = false;
          showNoConnectionDialog(); // Muestra el diálogo si pierde conexión
        }
      }
    });
  }

  Future<void> authenticate() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isDeviceSupported = await auth.isDeviceSupported();

      if (canCheckBiometrics && isDeviceSupported) {
        isAuthenticated.value = await auth.authenticate(
          localizedReason: 'Por favor autentíquese para continuar',
          // options: const AuthenticationOptions(
          //   useErrorDialogs: true,
          //   stickyAuth: true,
          // ),
        );
      } else {
        // Si el dispositivo no soporta autenticación biométrica, continuar sin autenticación
        isAuthenticated.value = true;
      }
    } catch (e) {
      debugPrint(e.toString());
      // Si ocurre un error, permitir el acceso
      // isAuthenticated.value = true;
    }

    if (isAuthenticated.value) {
      // checkConnectivity();
      startListeningConnectionChanges(); // Iniciar el listener de conexión
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
    Get.dialog(
      barrierDismissible: false,
      CustomDialogLostConection(
        onRetry: () async {
          Get.back(); // Cierra el diálogo
          startListeningConnectionChanges(); // Reintenta la verificación
        },
      ),
    );
  }
}
