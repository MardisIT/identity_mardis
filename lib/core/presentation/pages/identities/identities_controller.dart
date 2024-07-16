import 'dart:convert';

import 'package:get/get.dart';
import 'package:identity_engine/core/application/Interfaces/ilogin_qr_provider.dart';
import 'package:identity_engine/core/domain/Models/identities.dart';
import 'package:identity_engine/core/domain/Models/login/login_response.dart';
import 'package:identity_engine/core/domain/Models/login/user_view_model.dart';
import 'package:identity_engine/core/presentation/home/home_controller.dart';
import 'package:identity_engine/core/presentation/pages/scanner_qr/scanner_controller.dart';
import 'package:identity_engine/core/presentation/widget/widgets.dart';
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

  Rx<Identity> identityData = Identity(
    id: '',
    time: 0,
    codestaitc: '',
    systemAplication: '',
    email: '',
    jsonPreference: '',
  ).obs;

  Rx<QRCodeData> qrResponse = QRCodeData(
    idUser: '',
    loginCode: '',
    phoneIdentifier: '',
    codeExpiration: '',
    timeExpiration: 0,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    loadIdentities();
  }

  Future<void> loadIdentities() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> identityStrings = prefs.getStringList('identities') ?? [];
    identities.value = [];
    for (var identity in identityStrings) {
      final Identity identityModel = Identity.fromJson(jsonDecode(identity));
      identities.add(identityModel);
      if (identityModel.progressValue.value < 1.0) {
        identityModel.code!.value = identityModel.codestaitc!;
        startProgressAnimation(identityModel);
      }
    }
  }

//************************************************************************************************

  // Future<void> updateIdentity(String id, int time, String code,
  //     String systemAplication, String email) async {
  //   // Identity newIdentity = Identity(
  //   //   id: id.value,
  //   //   time: time,
  //   //   codestaitc: code.value,
  //   //   systemAplication: systemAplication.value,
  //   //   email: email.value,
  //   //   jsonPreference: '',
  //   // );

  //   identityData.value = Identity(
  //     id: id,
  //     time: time,
  //     systemAplication: systemAplication,
  //     email: email,
  //     jsonPreference: '',
  //   );

  //   final identityJson = jsonEncode(identityData);
  //   identityData.value.jsonPreference = identityJson;
  //   identities.add(identityData.value);
  //   final prefs = await SharedPreferences.getInstance();

  //   List<String> identityStrings =
  //       identities.map((i) => i.jsonPreference).toList();

  //   await prefs.setStringList('identities', identityStrings);
  //   startProgressAnimation(identityData.value);
  // }

  //************************************************************************************************

  Future<void> addIdentity(String id, int time, String code,
      String systemAplication, String email) async {
    identityData.value = Identity(
      id: id,
      time: time,
      // code: code,
      codestaitc: code,
      systemAplication: systemAplication,
      email: email,
      jsonPreference: '',
    );

    final identitiTest = jsonEncode(identityData);
    identityData.value.jsonPreference = identitiTest;
    identities.add(identityData.value);
    final prefs = await SharedPreferences.getInstance();

    List<String> identityStrings =
        identities.map((i) => i.jsonPreference).toList();

    // List<String> identityStrings = identities.toJson();
    await prefs.setStringList('identities', identityStrings);
    identityData.value.code!.value = code;
    startProgressAnimation(identityData.value);
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
      const CustomDialog(),
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
    final ScannerController scannerController = Get.find();
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
              await getUser(identityData.value.id, scannerController.tenant);

          if (loginResponse.status == "success") {
            identities
                .where(
                  (x) => x.id == identity.id,
                )
                .first
                .code!
                .value = loginResponse.data!.loginCode;
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
