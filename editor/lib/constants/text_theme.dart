// text_styles.dart
import 'package:editor/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
// Import the colors file

TextTheme getTextTheme() {
  return TextTheme(
    headlineLarge: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      color: ConstColors.extralightmetal,
      decoration: TextDecoration.none,
      fontSize: 28.sp,
    ),
    headlineMedium: GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      color: Color(0xFFF0FBFF), // Example color
      decoration: TextDecoration.none,
      fontSize: 28.sp,
      height: 0,
    ),
    headlineSmall: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      color: Color(0xFFF0FBFF), // Example color
      decoration: TextDecoration.none,
      fontSize: 24.sp,
      height: 0.05,
    ),
    labelSmall: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      color: ConstColors.loginextralightgrey,
      decoration: TextDecoration.none,
      fontSize: 14.sp,
    ),
    bodySmall: GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      color: ConstColors.white,
      fontSize: 18.sp,
      height: 1.2,
    ),
    // Add more text styles as needed
  );
}
