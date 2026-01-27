import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:identity_engine/core/Styles/app_colors.dart';

final appTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.black,
    centerTitle: true,
  ),
  textTheme: GoogleFonts.nunitoTextTheme(),
  useMaterial3: true,
  
  // platform: TargetPlatform.android,
  // brightness: Brightness.dark,
  // scaffoldBackgroundColor: AppColors.white,
  // primaryColor: AppColors.deepBlue,
  // color for scrollbar
  // highlightColor: AppColors.white,
);
