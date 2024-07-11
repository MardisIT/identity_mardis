import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/domain/Models/identities.dart';
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
      backgroundColor: const Color(0xffFEF7FF),
      body:
          Obx(
        () => controller.identities.isNotEmpty
            ? ListView.builder(
                itemCount: controller.identities.length,
                itemBuilder: (context, index) {
                  return _IdentitiesContainer(
                    controller: controller,
                    scannerController: scannerController,
                    identity: controller.identities[index],
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
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Toque el icono "+" de abajo para comenzar',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: CustomFAB(controller: controller),
    );
  }
}

//* ⬇⬇⬇⬇ Widget privado para Contenedor de identidades ⬇⬇⬇⬇
class _IdentitiesContainer extends StatelessWidget {
  const _IdentitiesContainer({
    required this.controller,
    required this.scannerController,
    required this.identity,
    required this.index,
  });

  final IdentitiesController controller;
  final ScannerController scannerController;
  final Identity identity;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Container(
          height: 100,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade400,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Obx(
                () => SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    value: identity.progressValue.value,
                    valueColor: AlwaysStoppedAnimation(
                      Colors.red.shade100,
                    ),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Engine',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      identity.id,
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Checkbox(
                  value: identity.isChecked.value,
                  onChanged: (value) {
                    controller.toggleCheckbox(identity);
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  controller.removeIdentity(index);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
