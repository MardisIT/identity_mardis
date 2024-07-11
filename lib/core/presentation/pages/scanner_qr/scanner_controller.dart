import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/home/home_controller.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScannerController extends GetxController {
  final HomeController homeController = Get.find();
  final IdentitiesController identitiesController = Get.find();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;
  var qrResult = ''.obs;

  void updateQrResult(String result) async {
    qrResult.value = result;
    await addIdentity(result); // Añadir identidad escaneada y guardarla
    Get.snackbar('Código QR Escaneado', result);
  }

  Future<void> addIdentity(String identity) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> identities = prefs.getStringList('identities') ?? [];
    identities.add(identity);
    await prefs.setStringList('identities', identities);
    identitiesController.loadIdentities(); // Recargar identidades
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
        backgroundColor: Colors.green
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
