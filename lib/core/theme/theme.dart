import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/utils/app_colors.dart';

ThemeData getAppTheme() {
  return ThemeData(
      // scaffold background color
      scaffoldBackgroundColor: AppColors.background,
      // appBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        centerTitle: true,
      ),
      // text theme
      textTheme: TextTheme(
          displayLarge: GoogleFonts.lato(
            color: AppColors.white.withOpacity(.87),
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
          displayMedium: GoogleFonts.lato(
            color: AppColors.white.withOpacity(.87),
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          labelLarge: GoogleFonts.lato(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 24,
            fontStyle: FontStyle.normal
          ),
          displaySmall: GoogleFonts.lato(
            color: AppColors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          )),
      // button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)))));
}
