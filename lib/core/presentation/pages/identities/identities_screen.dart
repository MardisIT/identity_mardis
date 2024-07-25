import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/Styles/app_colors.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';
import 'package:identity_engine/core/presentation/pages/scanner_qr/scanner_controller.dart';
import 'package:identity_engine/core/presentation/widget/widgets.dart';

class IdentitiesScreen extends GetWidget<IdentitiesController> {
  const IdentitiesScreen({
    super.key,
  });

  

  @override
  Widget build(BuildContext context) {
    final ScannerController scannerController = Get.find();
    return Scaffold(
      body: Obx(
        () => controller.filteredIdentities.isNotEmpty
            ? ListView.builder(
                itemCount: controller.filteredIdentities.length,
                itemBuilder: (context, index) {
                  return IdentitiesContainer(
                    controller: controller,
                    scannerController: scannerController,
                    identity: controller.filteredIdentities[index],
                    index: index,
                  );
                },
              )
            : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No tienes identidades.',
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Toque el icono "+" de abajo para comenzar',
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (controller.isDeleteMode.value)
              FloatingActionButton(
                backgroundColor: AppColors.red,
                child: const Icon(
                  Icons.delete,
                  color: AppColors.white,
                ),
                onPressed: () {
                  controller.showDeleteConfirmationDialog();
                },
              ),
            const SizedBox(height: 10),
            if (!controller.isDeleteMode.value)
              CustomFAB(controller: controller),
          ],
        ),
      ),
    );
  }
}

