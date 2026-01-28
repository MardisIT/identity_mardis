import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/Routes/router.dart';
import 'package:identity_engine/core/presentation/widget/widgets.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:local_auth/local_auth.dart';

class AuthController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();
  final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker.createInstance();

  RxBool isAuthenticated = false.obs;
  RxBool isConnected = false.obs;
  RxBool isCheckingConnection = false.obs;
  bool _ignoreFirstConnectionEvent = true;

  StreamSubscription<InternetConnectionStatus>? connectionSubscription;

  @override
  void onInit() {
    super.onInit();
    authenticate();
  }

  @override
  void onClose() {
    connectionSubscription?.cancel();
    super.onClose();
  }

  // ================= BIOMETRÍA =================
  Future<void> authenticate() async {
    try {
      final canCheckBiometrics = await auth.canCheckBiometrics;
      final isDeviceSupported = await auth.isDeviceSupported();

      if (canCheckBiometrics && isDeviceSupported) {
        isAuthenticated.value = await auth.authenticate(
          localizedReason: 'Por favor autentíquese para continuar',
          biometricOnly: false,
          persistAcrossBackgrounding: true, // ← CLAVE para iOS
          sensitiveTransaction: true,
        );
      } else {
        isAuthenticated.value = true;
      }
    } catch (e) {
      debugPrint('Auth error: $e');
      isAuthenticated.value = true; // fallback
    }

    if (isAuthenticated.value) {
      await _checkInitialConnection();
      _startListeningConnectionChanges();
    }
  }

  // ================= CONEXIÓN INICIAL =================
  Future<void> _checkInitialConnection() async {
    isCheckingConnection.value = true;
    await showCheckingConnectionDialog();

    final status = await _connectionChecker.connectionStatus;

    isCheckingConnection.value = false;
    _closeDialogSafely();

    if (status == InternetConnectionStatus.connected) {
      isConnected.value = true;
      Get.offNamed(Routes.home);
    } else {
      isConnected.value = false;
      showNoConnectionDialog();
    }
  }

  // ================= LISTENER =================
  void _startListeningConnectionChanges() {
    connectionSubscription?.cancel();

    connectionSubscription =
        _connectionChecker.onStatusChange.listen((status) async {
      if (_ignoreFirstConnectionEvent) {
        _ignoreFirstConnectionEvent = false;
        return;
      }

      if (status == InternetConnectionStatus.disconnected) {
        final stillDisconnected = await _hasStableConnection();
        if (stillDisconnected && isConnected.value) {
          isConnected.value = false;
          showNoConnectionDialog();
        }
      }
    });
  }

  Future<bool> _hasStableConnection() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return await _connectionChecker.hasConnection;
  }

  // ================= DIÁLOGOS =================
  Future<void> showCheckingConnectionDialog() async {
    if (!(Get.isDialogOpen ?? false)) {
      Get.dialog(
        barrierDismissible: false,
        const AlertDialog(
          backgroundColor: Colors.black54,
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text(
                'Verificando conexión...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    }
  }

  void _closeDialogSafely() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  Future<void> showNoConnectionDialog() async {
    if (Get.isDialogOpen ?? false) return;

    Get.dialog(
      barrierDismissible: false,
      CustomDialogLostConection(
        onRetry: () async {
          _closeDialogSafely();
          await _checkInitialConnection();
        },
      ),
    );
  }
}
