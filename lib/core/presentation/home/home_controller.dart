import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/Routes/router.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  late PageController pageController;
  final TextEditingController searchController = TextEditingController();
  Rx<AppLifecycleState?> appLifecycleState = Rx<AppLifecycleState?>(null);
  RxInt currentPage = 0.obs;
  RxBool isSearching = false.obs;


  @override
  void onInit() async {
    super.onInit();
    pageController = PageController(initialPage: 0);
    WidgetsBinding.instance.addObserver(this);
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
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appLifecycleState.value = state;
    if (state == AppLifecycleState.paused) {
      Get.offAllNamed(Routes.auth);
    }
    super.didChangeAppLifecycleState(state);
  }
}
