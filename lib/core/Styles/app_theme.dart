import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class AppColors {
//   static const deepBlue = Color(0xff000334);
//   static const red = Color(0xffEF1D52);
//   static const green = Color(0xff23A566);
//   static const purple = Color(0xFF8652FF);
//   static const white = Color(0xffFFFFFF);
//   static const lightPurple = Color(0xffE6E5FF);
//   static const lightBlue = Color(0xff303257);
//   static const lightGreen = Color(0xff69f0ae);
//   static const lightYellow = Color(0xffffcc00);
//   static const orange = Colors.orange;
//   static const lightRed = Color(0xfffF1f61);
// }


final appTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    centerTitle: true,
  ),
  textTheme: GoogleFonts.ptSansTextTheme(),
  useMaterial3: true,
  // platform: TargetPlatform.android,
  // brightness: Brightness.dark,
  // scaffoldBackgroundColor: AppColors.white,
  // primaryColor: AppColors.deepBlue,
  // color for scrollbar
  // highlightColor: AppColors.white,
);
