import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/pages/configuration/configuration_controller.dart';
import 'package:identity_engine/core/presentation/pages/scanner_qr/scanner_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfigurationScreen extends GetWidget<ConfigurationController> {
  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScannerController scannerController = Get.find();

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 15,
        ),
        child: FutureBuilder(
          future: scannerController.initPlatformState(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              var infophone = snapshot.data as Map<String, dynamic>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Section(
                    title: 'DISPOSITIVO',
                    items: [
                      _SectionItem(
                        icon: Icons.phone_android_rounded,
                        title: 'Dispositivo',
                        subtitle:  Theme.of(context).platform == TargetPlatform.android
                        ?
                        infophone['device'] + ' - ' + infophone['model']
                        :
                        infophone['name']
                      ),
                      _SectionItem(
                        icon: Icons.phonelink_setup_rounded,
                        title: 'Versión del sistema operativo',
                        subtitle: Theme.of(context).platform == TargetPlatform.android
                        ? infophone['version.release']
                        : infophone['systemVersion']
                      ),
                    ],
                  ),
                  _Section(
                    title: 'ACERCA DE',
                    items: [
                      _SectionItem(
                        icon: Icons.info_outline_rounded,
                        title: 'Versión',
                        subtitle: controller.version,
                      ),
                      _SectionItem(
                        icon: Icons.policy_rounded,
                        secondIcon: Icons.navigate_next_rounded,
                        title: 'Políticas de privacidad',
                        onTap: () async {
                          final Uri url = Uri.parse(
                              'https://www.mardis.com.ec/politica_privacidad_datos/');
                          if (!await launchUrl(url)) {
                            throw 'No se pudo lanzar $url';
                          }
                        },
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<_SectionItem> items;

  const _Section({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          ...items,
        ],
      ),
    );
  }
}

class _SectionItem extends StatelessWidget {
  final IconData icon;
  final IconData? secondIcon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const _SectionItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.secondIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: subtitle != null
          ? Row(
              children: [
                Icon(icon, size: 40),
                const SizedBox(width: 15),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$title\n',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: subtitle,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : InkWell(
              onTap: onTap,
              splashColor: Colors.grey.shade300,
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 40,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Icon(
                    secondIcon,
                    size: 40,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
    );
  }
}
