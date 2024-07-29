import 'package:get/get.dart';
import 'package:identity_engine/core/Styles/app_colors.dart';
import 'package:identity_engine/core/application/Interfaces/ilogin_qr_provider.dart';
import 'package:identity_engine/core/domain/Models/identities.dart';
import 'package:identity_engine/core/domain/Models/login/login_response.dart';
import 'package:identity_engine/core/domain/Models/login/user_view_model.dart';
import 'package:identity_engine/core/infrastructure/base/userIdentityService.dart';
import 'package:identity_engine/core/infrastructure/base/userIndentity_ET.dart';
import 'package:identity_engine/core/presentation/home/home_controller.dart';
import 'package:identity_engine/core/presentation/widget/widgets.dart';

class IdentitiesController extends GetxController {
  ILoginProvider loginProverInterface;
  IdentitiesController({
    required this.loginProverInterface,
  });

  final Useridentityservice _service = Useridentityservice();
  final HomeController homeController = Get.find();

  var identities = <Identity>[].obs;
  var filteredIdentities = <Identity>[].obs;

  var deleteIdentitesIndex = <int>[].obs;
  var identitiesToDelete = <Identity>[].obs;
  var isDeleteMode = false.obs;

  Rx<Identity> identityData = Identity(
    id: '',
    time: 0,
    codestaitc: '',
    systemAplication: '',
    email: '',
    jsonPreference: '',
    tenant: '',
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
    var identityStrings = await _service.getAll();
    identities.value = [];
    for (var identity in identityStrings) {
      final Identity identityModel = Identity(
        id: identity.id,
        time: identity.time,
        codestaitc: identity.code.toString(),
        systemAplication: identity.systemAplication,
        email: identity.email,
        jsonPreference: '',
        tenant: identity.tenant,
      );
      identities.add(identityModel);
      if (identityModel.progressValue.value < 1.0) {
        identityModel.code!.value = identityModel.codestaitc!;
        // startProgressAnimation(identityModel);
      }
    }
    filteredIdentities.value = identities;
  }

  Future<void> addIdentity(
    String id,
    int time,
    String code,
    String systemAplication,
    String email,
    String tenant,
    String infophone,
  ) async {
    identityData.value = Identity(
      id: id,
      time: time,
      // code: code,
      codestaitc: code,
      systemAplication: systemAplication,
      email: email,
      jsonPreference: '',
      tenant: tenant,
    );
    var person = Userindentity(
      id,
      time,
      int.parse(code),
      systemAplication,
      email,
      tenant,
      infophone,
    );
    await _service.add(person);

    identities.add(identityData.value);
    identityData.value.code!.value = code;
  }

  //* Metodos para eliminacion de identidades

  Future<void> removeSelectedIdentities() async {
    for (var identity in deleteIdentitesIndex) {
      var model = await _service.getatById(identity);
      var result = await deleteUser(model!.id, model.tenant);
      if (result) {
        await _service.deleteat(identity);
      } else {
        Get.snackbar(
          'Error',
          'Fallo el desbloqueo del usuario',
          backgroundColor: AppColors.red.withOpacity(0.5),
          colorText: AppColors.white,
        );
      }
    }
    deleteIdentitesIndex.clear();
    isDeleteMode.value = false;
    loadIdentities();
  }

  void showDeleteConfirmationDialog() {
    Get.dialog(
      const CustomDialogDelete(),
    );
  }

  void toggleCheckbox(Identity identity, int index) {
    if (identitiesToDelete.contains(identity)) {
      identitiesToDelete.remove(identity);
      deleteIdentitesIndex.remove(index);
    } else {
      deleteIdentitesIndex.add(index);
      identitiesToDelete.add(identity);
    }
  }

  void toggleDeleteMode() {
    isDeleteMode.value = !isDeleteMode.value;
    identitiesToDelete.clear();
  }

  void cancelDeleteMode() {
    isDeleteMode.value = false;
    deleteIdentitesIndex.clear();
    identitiesToDelete.clear();
  }

  Future<bool> deleteUser(String idUser, String tenant) async {
    QRCodeResponse loginResponse = await loginProverInterface.deleteUserFromQR(
      idUser: idUser,
      tenant: tenant,
    );
    if (loginResponse.status == "success") {
      return true;
    }

    return false;
  }

  //* Metodos para eliminacion de identidades

  void startProgressAnimation(Identity identity) {
    if (identity.progressValue.value >= 0) {
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
                await getUser(identity.id, identity.tenant);

            if (loginResponse.status == "success") {
              identities
                  .where(
                    (x) => x.id == identity.id,
                  )
                  .first
                  .code!
                  .value = loginResponse.data!.loginCode;
              startProgressAnimation(identity);
            }
          }
        },
      );
    }
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

  void filterIdentities(String query) {
    if (query.isEmpty) {
      filteredIdentities.value = identities;
    } else {
      filteredIdentities.value = identities
          .where((identity) =>
              identity.systemAplication.contains(query) ||
              identity.email.contains(query))
          .toList();
    }
  }
}
