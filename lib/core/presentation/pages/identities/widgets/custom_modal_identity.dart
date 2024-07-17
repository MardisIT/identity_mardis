import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/domain/Models/identities.dart';
import 'package:identity_engine/core/presentation/pages/identities/identities_controller.dart';

class CustomModalIdentity extends StatelessWidget {
  const CustomModalIdentity({
    super.key,
    required this.identity,
  });

  final Identity identity;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IdentitiesController>();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Obx(
        () => Container(
          height: 400,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.key,
                size: 40,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${identity.systemAplication}\n',
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: identity.email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const Text(
                'Código multifactor de un solo uso',
                style: TextStyle(
                  fontSize: 17,
                ),
                maxLines: 2,
              ),
              SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  value: identity.progressValue.value,
                  valueColor: AlwaysStoppedAnimation(
                    Colors.green.shade100,
                  ),
                  backgroundColor: Colors.green,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    identity.code!.value,
                    style: const TextStyle(
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 20),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    identity.progressValue.value = -1;
                    controller.startProgressAnimation(identity);
                    Get.back();
                  },
                  child: const Text(
                    'Cerrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
