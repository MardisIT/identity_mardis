import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';
import 'package:identity_engine/core/presentation/pages/scanner_qr/scanner_controller.dart';

class IdentitiesScreen extends GetWidget<IdentitiesController> {
  const IdentitiesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ScannerController scannerController = Get.find();
    return Scaffold(
      backgroundColor: const Color(0xffFEF7FF),
      body: scannerController.qrResult.value.isNotEmpty
          ? Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffFEF7FF),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ],
                border: Border.all(
                  color: Colors.red.shade200,
                  width: 2,
                ),
                // color: Colors.green,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(
                    () => CircularProgressIndicator(
                      value: controller.progressValue.value,
                      valueColor: const AlwaysStoppedAnimation(
                        Colors.red,
                      ),
                      backgroundColor: Colors.red.shade100,
                    ),
                  ),
                  Text(
                    // '123456',
                    scannerController.qrResult.value,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Engine',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade600,
                    ),
                  )
                ],
              ),
            )
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No tienes identidades.',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Toque el icono "+" de abajo para comenzar',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
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
