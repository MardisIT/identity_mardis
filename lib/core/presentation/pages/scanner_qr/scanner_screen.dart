import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';
import 'scanner_controller.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScannerController scannerController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Intente Centrar el código QR en la pantalla'),
        centerTitle: true,
      ),
      body: QRView(
        key: scannerController.qrKey,
        onQRViewCreated: scannerController.onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 300,
        ),
      ),
    );
  }
}
