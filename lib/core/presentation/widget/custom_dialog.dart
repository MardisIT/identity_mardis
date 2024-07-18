import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final IdentitiesController identitiesController = Get.find();
    return AlertDialog(
      icon: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.red, width: 5),
        ),
        child: const Icon(
          Icons.question_mark_outlined,
          size: 40,
          color: Colors.red,
        ),
      ),
      title: const Text(
        'Confirmar eliminación',
        style: TextStyle(
          fontSize: 22,
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
              height: 40,
              width: 100,
              child: TextButton(
                 style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    Colors.black,
                  ),
                
                ),
                onPressed: () {
                  identitiesController.cancelDeleteMode();
                  Get.back(); // Cerrar el diálogo
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: 100,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    Colors.red,
                  ),
                ),
                onPressed: () {
                  Get.back(); // Cerrar el diálogo
                  identitiesController.removeSelectedIdentities();
                },
                child: const Text(
                  'Eliminar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
