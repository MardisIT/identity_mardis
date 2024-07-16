import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/domain/Models/identities.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';
import 'package:identity_engine/core/presentation/pages/scanner_qr/scanner_controller.dart';

class IdentitiesContainer extends StatelessWidget {
  const IdentitiesContainer({
    super.key,
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${identity.systemAplication} - ${identity.email}',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                      Obx(
                        () {
                          return Text(
                            identity.code!.value,
                            // controller.identityData.value.code.toString(),
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              Obx(
                () => controller.isDeleteMode.value
                    ? Checkbox(
                        value: controller.isDeleteMode.value
                            ? controller.identitiesToDelete.contains(identity)
                            : identity.isChecked.value,
                        onChanged: (value) {
                          controller.toggleCheckbox(identity);
                        },
                        activeColor: Colors.red,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
