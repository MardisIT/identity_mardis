import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/Routes/router.dart';
import 'package:identity_engine/core/application/Interfaces/ilocal_provider.dart';
class MainController extends GetxController {
  final ILocalProvider localProviderInterface;
  MainController({required this.localProviderInterface});
  @override
  void onReady() {
    requestPermission();
    super.onReady();
  }

  void requestPermission() async {
    try {
      
      Get.offNamed(Routes.home);

    } catch (e) {
      Get.snackbar(
        "ERROR",
        "Ocurrió un problema, Fallo al obtener permisos de $e",
        duration: const Duration(days: 365),
        isDismissible: false,
        backgroundColor: Colors.white,
        colorText: Colors.black12,
      );
    }
  }
}
