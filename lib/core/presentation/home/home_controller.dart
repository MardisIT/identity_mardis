import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';
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

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
 //************************************************************************************************
  RxBool isSearching = false.obs;
  final TextEditingController searchController = TextEditingController();

  void startSearch() {
    isSearching.value = true;
  }

  void stopSearch() {
    final IdentitiesController identitiesController = Get.find();

    isSearching.value = false;
    searchController.clear();
    identitiesController.filterIdentities('');
  }
  //************************************************************************************************
}
