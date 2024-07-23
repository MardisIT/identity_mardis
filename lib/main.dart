import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:identity_engine/core/Routes/router.dart';
import 'package:identity_engine/core/Styles/app_theme.dart';
import 'package:identity_engine/core/infrastructure/base/userIdentityAdapter.dart';
import 'package:identity_engine/core/presentation/initialMain/initial_main_bindings.dart';

void main() async {
   await Hive.initFlutter();
    Hive.registerAdapter(UserIdentityAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Identity Engine',
      theme: appTheme,
      getPages: RoutesPages.pages,
      initialRoute: Routes.auth,
      initialBinding: MainBindings(),
    ),
  );
}
