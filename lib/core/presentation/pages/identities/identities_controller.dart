import 'package:get/get.dart';
import 'package:identity_engine/core/domain/Models/identities.dart';
import 'package:identity_engine/core/presentation/home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdentitiesController extends GetxController {
  final HomeController homeController = Get.find();
  var identities = <Identity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadIdentities();
  }

  Future<void> loadIdentities() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> identityStrings = prefs.getStringList('identities') ?? [];
    identities.value = identityStrings.map((id) => Identity(id: id)).toList();
    for (var identity in identities) {
      startProgressAnimation(identity);
    }
  }

  Future<void> addIdentity(String id) async {
    Identity newIdentity = Identity(id: id);
    identities.add(newIdentity);
    final prefs = await SharedPreferences.getInstance();
    List<String> identityStrings = identities.map((i) => i.id).toList();
    await prefs.setStringList('identities', identityStrings);
    startProgressAnimation(newIdentity);
  }

  Future<void> removeIdentity(int index) async {
    identities.removeAt(index);
    final prefs = await SharedPreferences.getInstance();
    List<String> identityStrings = identities.map((i) => i.id).toList();
    await prefs.setStringList('identities', identityStrings);
  }

  void startProgressAnimation(Identity identity) {
    const int durationInSeconds = 30;
    const int steps = durationInSeconds * 10; // 10 steps per second
    const int stepDuration = 1000 ~/ 10; // 100 milliseconds per step

    Future.delayed(
      const Duration(milliseconds: stepDuration),
      () {
        if (identity.progressValue.value < 1.0) {
          identity.progressValue.value += 1 / steps;
          startProgressAnimation(identity);
        } else {
          identity.progressValue.value = 0.0;
          startProgressAnimation(identity);
        }
      },
    );
  }

  void toggleCheckbox(Identity identity) {
    identity.isChecked.value = !identity.isChecked.value;
  }
}
