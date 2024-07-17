import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            height: 80,
            width: double.infinity,
            // padding: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              color: Colors.white,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: EdgeInsets.symmetric(horizontal: 0),
                foregroundColor: Colors.black,
              ),
              onPressed: () {},
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Obx(
                  //   () =>
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
                    // child: Icon(Icons.account_box_outlined),
                    child: const Icon(
                      Icons.assignment_ind_rounded,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                  //! ====================== ESTE ES EL EL CIRCULARPROGRESS DE LOS 30S ======================
                  // SizedBox(
                  //   height: 50,
                  //   width: 50,
                  //   child: CircularProgressIndicator(
                  //     // value: identity.progressValue.value,
                  //     value: 0,
                  //     valueColor: AlwaysStoppedAnimation(
                  //       Colors.red.shade100,
                  //     ),
                  //     backgroundColor: Colors.red,
                  //   ),
                  // ),
                  // ),
                  //! ====================== ESTE ES EL EL CIRCULARPROGRESS DE LOS 30S ======================
                  const Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // '${identity.systemAplication} - ${identity.email}',
                            'Engine',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          // Obx(
                          //   () =>
                          Text(
                            // identity.code!.value,
                            'olarreategui@mardisresearch.com',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.navigate_next_rounded,
                      size: 45,
                      color: Colors.black,
                    ),
                  )
                  // Obx(
                  //   () => controller.isDeleteMode.value
                  //       ? Checkbox(
                  //           value: controller.isDeleteMode.value
                  //               ? controller.identitiesToDelete.contains(identity)
                  //               : identity.isChecked.value,
                  //           onChanged: (value) {
                  //             controller.toggleCheckbox(identity);
                  //           },
                  //           activeColor: Colors.red,
                  //         )
                  //       : const SizedBox.shrink(),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      // body: Obx(
      //   () => controller.identities.isNotEmpty
      //       ? ListView.builder(
      //           itemCount: controller.identities.length,
      //           itemBuilder: (context, index) {
      //             return IdentitiesContainer(
      //               controller: controller,
      //               scannerController: scannerController,
      //               identity: controller.identities[index],
      //               index: index,
      //             );
      //           },
      //         )
      //       : const Center(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text(
      //                 'No tienes identidades.',
      //                 style: TextStyle(
      //                   fontSize: 17,
      //                   color: Colors.grey,
      //                 ),
      //               ),
      //               SizedBox(height: 20),
      //               Text(
      //                 'Toque el icono "+" de abajo para comenzar',
      //                 style: TextStyle(
      //                   fontSize: 17,
      //                   color: Colors.grey,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      // ),
      // floatingActionButton: Obx(
      //   () => Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       if (controller.isDeleteMode.value)
      //         FloatingActionButton(
      //           backgroundColor: Colors.red,
      //           child: const Icon(
      //             Icons.delete,
      //             color: Colors.white,
      //           ),
      //           onPressed: () {
      //             controller.showDeleteConfirmationDialog();
      //           },
      //         ),
      //       const SizedBox(height: 10),
      //       if (!controller.isDeleteMode.value)
      //         CustomFAB(controller: controller),
      //     ],
      //   ),
      // ),
    );
  }
}
