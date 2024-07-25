import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:identity_engine/core/Styles/app_colors.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({
    super.key,
    required this.controller,
  });

  final IdentitiesController controller;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      iconTheme: const IconThemeData(color: AppColors.white),
      icon: Icons.add,
      activeIcon: Icons.close,
      label: const Text(
        'Añadir identidad',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      spaceBetweenChildren: 20,
      backgroundColor: Colors.black,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.qr_code_scanner_rounded),
          label: 'Código QR',
          backgroundColor: Colors.green,
          foregroundColor: AppColors.white,
          shape: const CircleBorder(),
          onTap: () => controller.homeController.goToTab(1),
        ),
        SpeedDialChild(
          child: const Icon(Icons.delete),
          label: 'Eliminar',
          backgroundColor: AppColors.red,
          foregroundColor: AppColors.white,
          shape: const CircleBorder(),
          onTap: () {
            controller.toggleDeleteMode();
          },
        ),
      ],
    );
  }
}
