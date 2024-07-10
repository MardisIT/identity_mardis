import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/home/home_bindings.dart';
import 'package:identity_engine/core/presentation/initialMain/initial_main_bindings.dart';
import 'package:identity_engine/core/presentation/initialMain/initial_main_screen.dart';
import 'package:identity_engine/core/presentation/home/home_screen.dart';
import 'package:identity_engine/core/presentation/pages/scanner_qr/scanner_bindings.dart';
import 'package:identity_engine/core/presentation/pages/scanner_qr/scanner_screen.dart';
import 'package:identity_engine/main_bindings.dart';

class Routes {
  static const String splash = '/splash';
  static const String home = '/login';
  static const String scanner = '/scanner';
}

class RoutesPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const MainScreen(),
      bindings: [MainBindingsExt(), MainBindings()],
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      bindings: [MainBindingsExt(), HomeBindings(), ScannerBindings()],
    ),
    GetPage(
      name: Routes.scanner,
      page: () => const ScannerScreen(),
      bindings: [MainBindingsExt(), ScannerBindings()],
    ),
  ];
}
