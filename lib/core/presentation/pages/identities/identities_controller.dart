import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/domain/Models/identities.dart';
import 'package:identity_engine/core/presentation/home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdentitiesController extends GetxController {
  final HomeController homeController = Get.find();

  var identities = <Identity>[].obs;

  var identitiesToDelete = <Identity>[].obs;
  var isDeleteMode = false.obs;

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
      if (identity.progressValue.value < 1.0) {
        startProgressAnimation(identity);
      }
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

  //* Metodos para eliminacion de identidades

  Future<void> removeSelectedIdentities() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> currentIdentities = prefs.getStringList('identities') ?? [];

    for (var identity in identitiesToDelete) {
      currentIdentities.remove(identity.id);
    }

    await prefs.setStringList('identities', currentIdentities);
    loadIdentities();
    isDeleteMode.value = false;
  }

  void showDeleteConfirmationDialog() {
    Get.dialog(
      AlertDialog(
        icon: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.red, width: 5),
          ),
          child: const Icon(
            Icons.question_mark_outlined,
            size: 60,
            color: Colors.red,
          ),
        ),
        title: const Text(
          'Confirmar eliminación',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          '¿Está seguro que desea eliminar las identidades seleccionadas?',
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 50,
                width: 120,
                child: TextButton(
                  style: ButtonStyle(
                    side: WidgetStateProperty.all(
                      const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  onPressed: () {
                    cancelDeleteMode();
                    Get.back(); // Cerrar el diálogo
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 120,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Colors.red,
                    ),
                  ),
                  onPressed: () {
                    Get.back(); // Cerrar el diálogo
                    removeSelectedIdentities();
                  },
                  child: const Text(
                    'Eliminar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void toggleCheckbox(Identity identity) {
    if (identitiesToDelete.contains(identity)) {
      identitiesToDelete.remove(identity);
    } else {
      identitiesToDelete.add(identity);
    }
  }

  void toggleDeleteMode() {
    isDeleteMode.value = !isDeleteMode.value;
    identitiesToDelete.clear();
  }

  void cancelDeleteMode() {
    isDeleteMode.value = false;
    identitiesToDelete.clear();
  }

  //* Metodos para eliminacion de identidades

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
}
