import 'package:get/get.dart';

class IdentitiesController extends GetxController {
  RxDouble progressValue = 0.0.obs;

  void startProgressAnimation() {
    const int durationInSeconds = 30;
    const int steps = durationInSeconds * 10; // 10 steps per second
    const int stepDuration = 1000 ~/ 10; // 100 milliseconds per step

    Future.delayed(const Duration(milliseconds: stepDuration), () {
      if (progressValue.value < 1.0) {
        progressValue.value += 1 / steps;
        startProgressAnimation();
      } else {
        progressValue.value = 0.0;
        startProgressAnimation();
      }
    });
  }

  @override
  void onInit() {
    startProgressAnimation();
    super.onInit();
  }
}
