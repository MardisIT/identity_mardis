import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/Styles/app_colors.dart';
import 'package:identity_engine/core/presentation/home/home_controller.dart';
import 'package:identity_engine/core/presentation/pages/configuration/configuration_screen.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_screen.dart';
import 'package:identity_engine/core/presentation/pages/scanner_qr/scanner_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final IdentitiesController identitiesController = Get.find();

    return Obx(
      () => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, __) {
          if (!didPop) {
            Fluttertoast.showToast(
              msg: 'En esta pantalla no se puede usar el botón de retroceso',
              timeInSecForIosWeb: 5,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.grey.shade800,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: (controller.isSearching.value &&
                    controller.currentPage.value == 0)
                ? TextField(
                    controller: controller.searchController,
                    autofocus: true,
                    style: const TextStyle(
                      color: AppColors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Buscar...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                    onChanged: (query) {
                      identitiesController.filterIdentities(query);
                    },
                  )
                : const Text(
                    'Mardis Identity',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
            leading: (controller.isSearching.value &&
                    controller.currentPage.value == 0)
                ? IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.white,
                    ),
                    onPressed: controller.stopSearch,
                  )
                : null,
            actions: (controller.isSearching.value &&
                    controller.currentPage.value == 0)
                ? [
                    IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        controller.searchController.clear();
                        identitiesController.filterIdentities('');
                      },
                    ),
                  ]
                : [
                    if (controller.currentPage.value == 0)
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: AppColors.white,
                        ),
                        onPressed: controller.startSearch,
                      )
                  ],
          ),
          body: PageView(
            onPageChanged: controller.animateToTab,
            controller: controller.pageController,
            physics: const BouncingScrollPhysics(),
            children: const [
              IdentitiesScreen(),
              ScannerScreen(),
              ConfigurationScreen(),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: AppColors.white,
            notchMargin: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _bottomAppBarItem(
                  context,
                  icon: Icons.fingerprint_rounded,
                  page: 0,
                  label: 'Identidades',
                ),
                _bottomAppBarItem(
                  context,
                  icon: Icons.qr_code_scanner_rounded,
                  page: 1,
                  label: 'Escaneo de QR',
                ),
                _bottomAppBarItem(
                  context,
                  icon: Icons.perm_device_information_rounded,
                  page: 2,
                  label: 'Información',
                ),
              ],
            ),
            // ),
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(
    BuildContext context, {
    required icon,
    required page,
    required label,
  }) {
    return ZoomTapAnimation(
      onTap: () => controller.goToTab(page),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color: controller.currentPage.value == page
                  ? AppColors.red
                  : AppColors.grey),
          Text(
            label,
            style: TextStyle(
              color: controller.currentPage.value == page
                  ? AppColors.red
                  : AppColors.grey,
              fontSize: 13,
              fontWeight:
                  controller.currentPage.value == page ? FontWeight.w600 : null,
            ),
          ),
        ],
      ),
    );
  }
}
