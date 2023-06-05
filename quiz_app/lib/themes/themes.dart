import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'styles_text.dart';

class AppTheme {
  static ThemeData get lightThem {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.white,
      backgroundColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.background1,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: AppFont.appFont,
      indicatorColor: AppColors.white,
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black),
        hintStyle: TextStyle(color: Colors.grey),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.white,
        selectionColor: AppColors.primary1.withOpacity(0.5),
        selectionHandleColor: AppColors.primary1.withOpacity(0.5),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.white,
        onSurface: Colors.black,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
    );
  }
}
