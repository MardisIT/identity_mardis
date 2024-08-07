import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/Styles/app_colors.dart';
import 'package:identity_engine/core/domain/Models/identities.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';
import 'package:identity_engine/core/presentation/pages/identities/widgets/custom_modal_identity.dart';
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
        const SizedBox(height: 10),
        Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade400,
                width: 1,
              ),
              top: BorderSide(
                color: Colors.grey.shade400,
                width: 1,
              ),
            ),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 0),
              foregroundColor: AppColors.black,
              backgroundColor: AppColors.white,
            ),
            onPressed: () {
              showDialog(identity);
            },
            child: Row(
              children: [
                Container(
                  height: double.maxFinite,
                  width: 10,
                  color: Colors.black,
                ),
                const SizedBox(width: 10),
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.assignment_ind_rounded,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          identity.systemAplication,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          identity.email,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
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
                            controller.toggleCheckbox(identity, index);
                          },
                          activeColor: AppColors.red,
                        )
                      : const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.navigate_next_rounded,
                            size: 45,
                            color: AppColors.black,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showDialog(Identity identity) {
    identity.progressValue.value = 1.0;
    controller.startProgressAnimation(identity);
    identity.code!.value = '';

    Get.dialog(
      CustomModalIdentity(
        identity: identity,
      ),
    );
  }
}
