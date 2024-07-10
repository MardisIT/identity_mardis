import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/pages/scanner_qr/scanner_controller.dart';

class IdentitiesScreen extends GetWidget<ScannerController> {
  const IdentitiesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        height: 70,
        width: double.infinity ,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Colors.grey,
            width: 3
          ),
          // color: Colors.green,
        ),
        // color: Colors.green,
      ),
    );
    // Center(
    //   child: Text(
    //     controller.qrResult.value.isNotEmpty
    //         ? controller.qrResult.value
    //         : 'No tienes identidades.',
    //     textAlign: TextAlign.center,
    //     style: TextStyle(
    //       fontSize: 18,
    //     ),
    //   ),
    // );
  }
}
