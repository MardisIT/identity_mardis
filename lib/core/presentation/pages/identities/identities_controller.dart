import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/application/Interfaces/ilogin_qr_provider.dart';
import 'package:identity_engine/core/domain/Models/identities.dart';
import 'package:identity_engine/core/domain/Models/login/login_response.dart';
import 'package:identity_engine/core/presentation/home/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdentitiesController extends GetxController {
  ILoginProvider loginProverInterface;

  IdentitiesController({
    required this.loginProverInterface,
  });

  final HomeController homeController = Get.find();

  var identities = <Identity>[].obs;

  var identitiesToDelete = <Identity>[].obs;
  var isDeleteMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadIdentities();
    // getUser('c34fdd0f-8e18-4167-b869-f73c463188e7', 'StoreAudit');
  }

  Future<void> loadIdentities() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> identityStrings = prefs.getStringList('identities') ?? [];
    identities.value = [];
    for (var identity in identityStrings) {
      final Identity identityModel = Identity.fromJson(jsonDecode(identity));
      identities.add(identityModel);
      if (identityModel.progressValue.value < 1.0) {
        startProgressAnimation(identityModel);
      }
    }
  }

//************************************************************************************************

  Future<void> updateIdentity(RxString id, int time, RxString code,
      RxString systemAplication, RxString email) async {
    Identity newIdentity = Identity(
      id: id.value,
      time: time,
      code: code,
      systemAplication: systemAplication.value,
      email: email.value,
      jsonPreference: '',
    );

    final identityJson = jsonEncode(newIdentity);
    newIdentity.jsonPreference = identityJson;
    identities.add(newIdentity);
    final prefs = await SharedPreferences.getInstance();

    List<String> identityStrings =
        identities.map((i) => i.jsonPreference).toList();

    await prefs.setStringList('identities', identityStrings);
    startProgressAnimation(newIdentity);
  }

  //************************************************************************************************

  Future<void> addIdentity(RxString id, int time, RxString code,
      RxString systemAplication, RxString email) async {
    Identity newIdentity = Identity(
      id: id.value,
      time: time,
      code: code,
      systemAplication: systemAplication.value,
      email: email.value,
      jsonPreference: '',
    );

    final identitiTest = jsonEncode(newIdentity);
    newIdentity.jsonPreference = identitiTest;
    identities.add(newIdentity);
    final prefs = await SharedPreferences.getInstance();

    List<String> identityStrings =
        identities.map((i) => i.jsonPreference).toList();

    // List<String> identityStrings = identities.toJson();
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
    int durationInSeconds = identity.time;
    int steps = durationInSeconds * 10; // 10 steps per second
    const int stepDuration = 1000 ~/ 10; // 100 milliseconds per step

    Future.delayed(
      const Duration(milliseconds: stepDuration),
      () async {
        if (identity.progressValue.value < 1.0) {
          identity.progressValue.value += 1 / steps;
          startProgressAnimation(identity);
        } else {
          identity.progressValue.value = 0.0;
          // getUser(identity.id, 'StoreAudit');
          QRCodeResponse loginResponse =
              await getUser(identity.id, 'StoreAudit');

          if (loginResponse.status == "success") {
            // identity.code = loginResponse.data!.loginCode;
            identities.where(
              (x) => x.id == identity.id,
            ).first.code.value = loginResponse.data!.loginCode;
          }
          startProgressAnimation(identity);
        }
      },
    );
  }

  Future<QRCodeResponse> getUser(String idUser, String tenant) async {
    QRCodeResponse loginResponse = await loginProverInterface.getUserFromQR(
      idUser: idUser,
      tenant: tenant,
    );

    if (loginResponse.status != "success") {
      loadIdentities();
    }
    return loginResponse;
  }
}
