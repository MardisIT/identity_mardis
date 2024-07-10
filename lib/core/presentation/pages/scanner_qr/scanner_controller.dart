import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/home/home_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final HomeController homeController = Get.find();

  var qrResult = ''.obs;
  QRViewController? qrViewController;

  @override
  void onInit() {
    super.onInit();
    requestCameraPermission();
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
    qrViewController = controller;
    controller.scannedDataStream.listen((scanData) {
      updateQrResult(scanData.code!);
      homeController.animateToTab(0); // Navegar a la pestaña de identidades
      controller.dispose(); // Detener la cámara
    });
  }

  void updateQrResult(String result) {
    // Actualiza el resultado del escaneo QR
    qrResult.value = result;
    Get.snackbar('Código QR Escaneado', result);
  }

  @override
  void onClose() {
    qrViewController?.dispose();
    super.onClose();
  }
}
