import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/home/home_controller.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_screen.dart';
import 'package:identity_engine/core/presentation/pages/scanner_qr/scanner_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mardis Identity',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        // backgroundColor: const Color(0xffFF0000),
        backgroundColor: Colors.black,
      ),
      body: Obx(
        () {
          if (controller.isAuthenticated.value) {
            return PageView(
              onPageChanged: controller.animateToTab,
              controller: controller.pageController,
              physics: const BouncingScrollPhysics(),
              children: [
                IdentitiesScreen(),
                ScannerScreen(),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        notchMargin: 10,
        child: Obx(
          () => Row(
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
              // _bottomAppBarItem(
              //   context,
              //   icon: Icons.settings_rounded,
              //   page: 0,
              //   label: 'Configuración',
              // ),
            ],
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
