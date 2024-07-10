import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:identity_engine/core/presentation/initialMain/initial_main_controller.dart';

class MainScreen extends GetWidget<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Text("hola")),
    );
  }
}
