import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/pages/scanner_qr/scanner_controller.dart';

class ScannerBindings extends Bindings {
  @override
  void dependencies() => Get.lazyPut(
        () => ScannerController(),
      );
}
