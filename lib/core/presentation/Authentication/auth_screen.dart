import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/Authentication/auth_controller.dart';

// class AuthScreen extends GetWidget<AuthController> {
//   const AuthScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   if (controller.isCheckingConnection.value) {
//     //     controller.showCheckingConnectionDialog(context);
//     //   }
//     // });

//     return Scaffold(
//       body: Center(
//         child: Obx(() {
//           if (!controller.isCheckingConnection.value) {
//             // Cerrar el diálogo si no estamos verificando la conexión
//             if (Navigator.canPop(context)) {
//               Navigator.pop(context);
//             }

//             if (!controller.isConnected.value) {
//               WidgetsBinding.instance.addPostFrameCallback(
//                 (_) {
//                   controller.showNoConnectionDialog();
//                 },
//               );
//               // Mostrar contenido de conexión fallida mientras se muestra el diálogo
//               return _buildMainContent();
//             }

//             return _buildMainContent();
//           }
//           // Mostrar el contenido mientras se verifica la conexión
//           return _buildMainContent();
//         }),
//       ),
//     );
//   }

//   Widget _buildMainContent() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Spacer(),
//         Image.asset(
//           'assets/Logo_Mardis.png',
//           height: 80,
//         ),
//         const SizedBox(height: 20),
//         const Text(
//           'Aplicación Mardis Identity bloqueada',
//           style: TextStyle(
//             fontSize: 20,
//           ),
//         ),
//         const Spacer(),
//         GestureDetector(
//           onTap: () {
//             controller.authenticate();
//           },
//           child: const Text(
//             'DESBLOQUEAR',
//             style: TextStyle(
//               fontSize: 16,
//             ),
//           ),
//         ),
//         const SizedBox(height: 60),
//       ],
//     );
//   }
// }

class AuthScreen extends GetWidget<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
        ),
      ),
    );
  }
}
