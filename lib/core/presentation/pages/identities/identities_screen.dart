import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/pages/scanner_qr/scanner_controller.dart';

class IdentitiesScreen extends GetWidget<ScannerController> {
  const IdentitiesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        controller.qrResult.value.isNotEmpty
            ? controller.qrResult.value
            : 'No tienes identidades.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
