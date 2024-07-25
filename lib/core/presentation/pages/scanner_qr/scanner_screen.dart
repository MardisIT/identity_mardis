import 'package:flutter/material.dart';
import 'package:identity_engine/core/Styles/app_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';
import 'scanner_controller.dart';

class ScannerScreen extends GetWidget<ScannerController> {
  const ScannerScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: AppColors.white,
              child: const Center(
                child: Text(
                  'Intente Centrar el código QR en la pantalla',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 23,
            child: QRView(
              key: controller.qrKey,
              onQRViewCreated: controller.onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: AppColors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
