import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/home/home_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerController extends GetxController {
  final HomeController homeController = Get.find();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;
  var qrResult = ''.obs;

  void updateQrResult(String result) {
    qrResult.value = result;
    Get.snackbar('Código QR Escaneado', result);
  }

  @override
  void onInit() {
    super.onInit();
    if (homeController.currentPage.value == 1) {
      requestCameraPermission();
    }
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.request();
    if (!status.isGranted) {
      Get.snackbar(
        'Permiso requerido',
        'La cámara es necesaria para escanear códigos QR',
      );
    }
  }

  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      updateQrResult(scanData.code!);
      homeController.animateToTab(0); // Navegar a la pestaña de identidades
      controller.dispose(); // Detener la cámara
    });
  }

  @override
  void onClose() {
    qrViewController?.dispose();
    super.onClose();
  }
}
