import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/core/utils/app_colors.dart';

ThemeData getAppDarkTheme() {
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
        bodyLarge: GoogleFonts.lato(
          color: AppColors.white.withOpacity(.87),
          fontWeight: FontWeight.bold,
          fontSize: 40.sp,
        ),
        displayLarge: GoogleFonts.lato(
          color: AppColors.white.withOpacity(.87),
          fontWeight: FontWeight.bold,
          fontSize: 28.sp,
        ),
        displayMedium: GoogleFonts.lato(
          color: AppColors.white.withOpacity(.87),
          fontWeight: FontWeight.normal,
          fontSize: 14.sp,
        ),
        labelLarge: GoogleFonts.lato(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            fontStyle: FontStyle.normal),
        displaySmall: GoogleFonts.lato(
          color: AppColors.white,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        )),
    // button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
    inputDecorationTheme: InputDecorationTheme(
      // enabled border
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 0.8.w, color: AppColors.grey),
      ),
      // focused border
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 0.8.w, color: AppColors.grey),
      ),
      // hint
      hintStyle: GoogleFonts.lato(
        color: AppColors.white.withOpacity(.87),
        fontWeight: FontWeight.normal,
        fontSize: 14.sp,
      ),
      // fill color
      fillColor: AppColors.lightBlack, filled: true,
    ),
  );
}

ThemeData getAppTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    // scaffold background color
    scaffoldBackgroundColor: AppColors.white,
    // appBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      centerTitle: true,
    ),
    // text theme
    textTheme: TextTheme(
        bodyLarge: GoogleFonts.lato(
          color: AppColors.background.withOpacity(.87),
          fontWeight: FontWeight.bold,
          fontSize: 40.sp,
        ),
        displayLarge: GoogleFonts.lato(
          color: AppColors.background.withOpacity(.87),
          fontWeight: FontWeight.bold,
          fontSize: 28.sp,
        ),
        displayMedium: GoogleFonts.lato(
          color: AppColors.background.withOpacity(.87),
          fontWeight: FontWeight.normal,
          fontSize: 14.sp,
        ),
        labelLarge: GoogleFonts.lato(
            color: AppColors.background,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            fontStyle: FontStyle.normal),
        displaySmall: GoogleFonts.lato(
          color: AppColors.background,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
        )),
    // button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
    inputDecorationTheme: InputDecorationTheme(
      // enabled border
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 0.8.w, color: AppColors.grey),
      ),
      // focused border
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 0.8.w, color: AppColors.grey),
      ),
      // hint
      hintStyle: GoogleFonts.lato(
        color: AppColors.background.withOpacity(.87),
        fontWeight: FontWeight.normal,
        fontSize: 14.sp,
      ),
      // fill color
      fillColor: AppColors.white, filled: true,
    ),
  );
}
