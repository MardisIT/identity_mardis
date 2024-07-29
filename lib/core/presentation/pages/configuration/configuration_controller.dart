import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ConfigurationController extends GetxController {
  String version = '';

  @override
  void onInit() {
    super.onInit();
    getVersionCode();
  }

  void getVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }
}
