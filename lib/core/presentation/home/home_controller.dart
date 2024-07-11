import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class HomeController extends GetxController {
  late PageController pageController;
  RxInt currentPage = 0.obs;

  final LocalAuthentication auth = LocalAuthentication();
  RxBool isAuthenticated = false.obs;

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  Future<void> _authenticate() async {
    try {
      isAuthenticated.value = await auth.authenticate(
        localizedReason: 'Please authenticate to access this feature',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    _authenticate().then((_) {
      if (!isAuthenticated.value) {
        SystemNavigator.pop();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
