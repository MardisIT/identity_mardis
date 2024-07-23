import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/Authentication/auth_controller.dart';

class AuthScreen extends GetWidget<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            'assets/MARDIS-PRINCIPAL.png',
            height: 100,
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
              // Aquí puedes agregar la funcionalidad para desbloquear la aplicación
              controller.authenticate();
            },
            child: const Text(
              'DESBLOQUEAR',
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
