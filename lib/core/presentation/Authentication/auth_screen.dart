import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/Authentication/auth_controller.dart';

class AuthScreen extends GetWidget<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mostrar el diálogo inmediatamente al cargar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.isCheckingConnection.value) {
        _showCheckingConnectionDialog(context);
      }
    });

    return Scaffold(
      body: Center(
        child: Obx(() {
          if (!controller.isCheckingConnection.value) {
            // Cerrar el diálogo si no estamos verificando la conexión
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }

            if (!controller.isConnected.value) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  _showNoConnectionDialog(context);
                },
              );
              // Mostrar contenido de conexión fallida mientras se muestra el diálogo
              return _buildMainContent();
            }

            return _buildMainContent();
          }
          // Mostrar el contenido mientras se verifica la conexión
          return _buildMainContent();
        }),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        Image.asset(
          'assets/Logo_Mardis.png',
          height: 80,
        ),
        const SizedBox(height: 20),
        const Text(
          'Aplicación Mardis Identity bloqueada',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            controller.authenticate();
          },
          child: const Text(
            'DESBLOQUEAR',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }

  void _showCheckingConnectionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // No se puede cerrar el diálogo tocando fuera de él
      builder: (BuildContext context) {
        return const AlertDialog(
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
        );
      },
    );
  }

  void _showNoConnectionDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('No hay conexión a Internet'),
        content: const Text(
            'Por favor, verifica tu conexión a internet y vuelve a intentarlo.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              _showCheckingConnectionDialog(context);
              controller.checkConnectivity();
            },
            child: const Text('REINTENTAR'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
