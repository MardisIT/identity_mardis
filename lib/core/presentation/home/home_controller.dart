import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';
import 'package:local_auth/local_auth.dart';

class HomeController extends GetxController {
  late PageController pageController;
  final LocalAuthentication auth = LocalAuthentication();
  final TextEditingController searchController = TextEditingController();
  RxInt currentPage = 0.obs;
  RxBool isAuthenticated = false.obs;
  RxBool isSearching = false.obs;

  @override
  void onInit() async {
    pageController = PageController(initialPage: 0);

    _authenticate().then(
      (_) {
        if (!isAuthenticated.value) {
          SystemNavigator.pop();
        }
      },
    );
    super.onInit();
  }

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
      bool canCheckBiometrics = await auth.canCheckBiometrics;
      bool isDeviceSupported = await auth.isDeviceSupported();

      if (canCheckBiometrics && isDeviceSupported) {
        isAuthenticated.value = await auth.authenticate(
          localizedReason: 'Please authenticate to access this feature',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );
      } else {
        // Si el dispositivo no soporta autenticación biométrica, continuar sin autenticación
        isAuthenticated.value = true;
      }
    } catch (e) {
      print(e);
    }
  }

  void startSearch() {
    isSearching.value = true;
  }

  void stopSearch() {
    final IdentitiesController identitiesController = Get.find();

    isSearching.value = false;
    searchController.clear();
    identitiesController.filterIdentities('');
  }

  @override
  void onClose() {
    pageController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
