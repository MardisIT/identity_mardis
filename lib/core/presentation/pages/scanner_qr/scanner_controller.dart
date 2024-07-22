import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:identity_engine/Utils/Constants/info_devices.dart';
import 'package:identity_engine/Utils/Encryption/encryption.dart';
import 'package:identity_engine/core/application/Interfaces/ilogin_qr_provider.dart';
import 'package:identity_engine/core/domain/Models/login/login_request.dart';
import 'package:identity_engine/core/domain/Models/login/login_response.dart';
import 'package:identity_engine/core/infrastructure/base/userIdentityService.dart';
import 'package:identity_engine/core/presentation/home/home_controller.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ScannerController extends GetxController {
  ILoginProvider loginProverInterface;
  final Useridentityservice _hiveServiceUserIdentity = Useridentityservice();
  ScannerController({
    required this.loginProverInterface,
  });

  final HomeController homeController = Get.find();
  final IdentitiesController identitiesController = Get.find();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;
  var qrResult = ''.obs;
  var tenant = '';

  void updateQrResult(String result) async {
    qrResult.value = result;

    // Desencriptar el resultado
    try {
      final key = utf8.encode('E1BAD35C-DBA6-4B36-AC82-58E91582');
      final iv = utf8.encode('ABF01234567CDE89');

      // final encryptedData = base64Decode(
      //     'EFnPNpmZnC44gEzDNi+O9NfJXuddI4fkg0Kydm+08N6g2D5GzymqgTtKn31T9CWRHodhF+SSuLdHrxKYu9ZCuDRHtlD1/OgCyd8DYPG5MtI=');
      // final encryptedData = base64Decode(
      //     'D+KbjJgx/6KW7k87z3RYrtPHwuUpegb95+yJo6hh+0zHWa3bZ9//TeP0xrAslb3Qq4B5omdzRHkm29CRaPIoDA==');
      final encryptedData = base64Decode(result);

      final decryptedData = decrypt(Uint8List.fromList(encryptedData),
          Uint8List.fromList(key), Uint8List.fromList(iv));
      final decryptedString = utf8.decode(decryptedData);

      //* ----------------------------------------------------------------
      List<String> parts = decryptedString.split('&');

      String idUser = parts.length > 0 ? parts[0] : '';
      String systemAplication = parts.length > 2 ? parts[2] : '';
      tenant = parts.length > 3 ? parts[3] : '';
      String email = parts.length > 1 ? parts[1] : '';

      var userViewModel = await _hiveServiceUserIdentity.getAll();

      var _userRegister = userViewModel
          .where((element) => element.id.toUpperCase() == idUser.toUpperCase())
          .any((element) {
        return true;
      });
      if (_userRegister) {
        Get.snackbar(
          'Error',
          'El usuario  ya se encuentra registrado',
          backgroundColor: Colors.red.withOpacity(0.5),
          colorText: Colors.white,
        );
        return;
      }
      //* ----------------------------------------------------------------
      var infophone = await initPlatformState();
      // Añadir la identidad desencriptada
      var responseDecodeScanLogin = await loginUser(
          idUser, infophone['device'] + '-' + infophone['model'], tenant);

      if (responseDecodeScanLogin.status == 'success') {
        await identitiesController.addIdentity(
          responseDecodeScanLogin.data!.idUser,
          responseDecodeScanLogin.data!.timeExpiration,
          responseDecodeScanLogin.data!.loginCode,
          systemAplication,
          email,
          tenant,
          infophone['device'] + '-' + infophone['model'],
        );
        Get.snackbar(
          'OK!',
          'El usuario fue registrado en este dispositivo',
          backgroundColor: Colors.green.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
      if (responseDecodeScanLogin.status == 'No Exists') {
        Get.snackbar(
          'Error',
          'El usuario no está registrado en otro dispositivo. Por favor, contacte con soporte técnico.',
          backgroundColor: Colors.red.withOpacity(0.5),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Fallo al desencriptar el código QR',
        backgroundColor: Colors.red.withOpacity(0.5),
        colorText: Colors.white,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (homeController.currentPage.value == 1) {
      requestCameraPermission();
    }
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.request();
    if (!status.isGranted) {
      Get.snackbar(
        'Permiso requerido',
        'La cámara es necesaria para escanear códigos QR',
      );
    }
  }

  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      updateQrResult(scanData.code!);
      homeController.animateToTab(0); // Navegar a la pestaña de identidades
      controller.dispose(); // Detener la cámara
    });
  }

  @override
  void onClose() {
    qrViewController?.dispose();
    super.onClose();
  }

  Future<QRCodeResponse> loginUser(
      String idUser, String phoneIdentifier, String tenant) async {
    LoginRequestModel loginRequest =
        LoginRequestModel(idUser: idUser, phoneIdentifier: phoneIdentifier);
    QRCodeResponse loginResponse = await loginProverInterface.authenticatior(
      loginRequest: loginRequest,
      tenant: tenant,
    );

    if (loginResponse.status != "success") {}
    return loginResponse;
  }

  Future<dynamic> initPlatformState() async {
    var deviceData = <String, dynamic>{};
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      deviceData = switch (defaultTargetPlatform) {
        TargetPlatform.android =>
          readAndroidBuildData(await deviceInfoPlugin.androidInfo),
        TargetPlatform.iOS =>
          readIosDeviceInfo(await deviceInfoPlugin.iosInfo),
        TargetPlatform.linux =>
          readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo),
        TargetPlatform.windows =>
          readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo),
        TargetPlatform.macOS =>
          readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo),
        TargetPlatform.fuchsia => <String, dynamic>{
            'Error:': 'Fuchsia platform isn\'t supported'
          },
      };
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    return deviceData;
  }
}
