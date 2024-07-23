import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      () => Scaffold(
        appBar: AppBar(
          title: (controller.isSearching.value && controller.currentPage.value == 0)
              ? TextField(
                  controller: controller.searchController,
                  autofocus: true,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Buscar...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (query) {
                    identitiesController.filterIdentities(query);
                  },
                )
              : const Text(
                  'Mardis Identity',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
          leading: (controller.isSearching.value && controller.currentPage.value == 0)
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: controller.stopSearch,
                )
              : null,
          actions: (controller.isSearching.value && controller.currentPage.value == 0)
              ? [
                  IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.white,
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
                        color: Colors.white,
                      ),
                      onPressed: controller.startSearch,
                    )
                ],
        ),
        body: controller.isAuthenticated.value
            ? PageView(
                onPageChanged: controller.animateToTab,
                controller: controller.pageController,
                physics: const BouncingScrollPhysics(),
                children: const [
                  IdentitiesScreen(),
                  ScannerScreen(),
                  ConfigurationScreen(),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
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
          Icon(
            icon,
            color: controller.currentPage.value == page
                ? const Color(0xffFF0000)
                : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: controller.currentPage.value == page
                  ? const Color(0xffFF0000)
                  : Colors.grey,
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