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
                  identitiesController.cancelDeleteMode();
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
                  identitiesController.removeSelectedIdentities();
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
    );
  }
}
