import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/Styles/app_colors.dart';
import 'package:identity_engine/core/presentation/Authentication/auth_controller.dart';

class CustomDialogLostConection extends GetWidget<AuthController> {
  const CustomDialogLostConection({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.red, width: 5),
        ),
        child: const Icon(
          Icons.wifi_off_rounded,
          size: 40,
          color: AppColors.red,
        ),
      ),
      title: const Text(
        'No hay conexión a Internet',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Por favor, verifica tu conexión a internet y vuelve a intentarlo.',
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: SizedBox(
            height: 40,
            width: 110,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  AppColors.black,
                ),
              ),
              onPressed: () {
                Get.back();
                controller.showCheckingConnectionDialog(context);
                controller.checkConnectivity();
              },
              child: const Text(
                'Reintentar',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
