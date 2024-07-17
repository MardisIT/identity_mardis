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
    // return Column(
    //   children: [
    //     const SizedBox(height: 5),
    //     Container(
    //       height: 100,
    //       width: double.infinity,
    //       padding: const EdgeInsets.only(left: 15),
    //       decoration: BoxDecoration(
    //         border: Border(
    //           bottom: BorderSide(
    //             color: Colors.grey.shade400,
    //             width: 1,
    //           ),
    //         ),
    //       ),
    //       child: Row(
    //         children: [
    //           Obx(
    //             () => SizedBox(
    //               height: 50,
    //               width: 50,
    //               child: CircularProgressIndicator(
    //                 value: identity.progressValue.value,
    //                 valueColor: AlwaysStoppedAnimation(
    //                   Colors.red.shade100,
    //                 ),
    //                 backgroundColor: Colors.red,
    //               ),
    //             ),
    //           ),
    //           Expanded(
    //             child: Padding(
    //               padding: const EdgeInsets.only(left: 35),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     '${identity.systemAplication} - ${identity.email}',
    //                     style: TextStyle(
    //                       fontSize: 17,
    //                       color: Colors.black,
    //                     ),
    //                   ),
    //                   Obx(
    //                     () {
    //                       return Text(
    //                         identity.code!.value,
    //                         // controller.identityData.value.code.toString(),
    //                         style: const TextStyle(
    //                           fontSize: 35,
    //                           fontWeight: FontWeight.w500,
    //                           color: Colors.black,
    //                         ),
    //                       );
    //                     },
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Obx(
    //             () => controller.isDeleteMode.value
    //                 ? Checkbox(
    //                     value: controller.isDeleteMode.value
    //                         ? controller.identitiesToDelete.contains(identity)
    //                         : identity.isChecked.value,
    //                     onChanged: (value) {
    //                       controller.toggleCheckbox(identity);
    //                     },
    //                     activeColor: Colors.red,
    //                   )
    //                 : const SizedBox.shrink(),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
    return Column(
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
                foregroundColor: Colors.blue),
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
