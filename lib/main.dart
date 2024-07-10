import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/Routes/router.dart';
import 'package:identity_engine/core/presentation/initialMain/initial_main_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Identity Engine',
      getPages: RoutesPages.pages,
      initialRoute: Routes.home,
      initialBinding: MainBindings(),
    ),
  );
}