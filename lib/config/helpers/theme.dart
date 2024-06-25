import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primaryTextColor = Color(0xff294060);
  static const disabledPrimaryTextColor = Color.fromARGB(255, 77, 105, 145);
  static const primaryGreTextColor = Color(0xFF666666);
  static const secondaryColor = Color(0xff888AF4);
  static const lightOrange = Color(0x84EE9C58);
  static const darkOrange = Color(0xFF888AF4);
  static const darkerSecondaryColor = Color(0xff888AF4);
  static const lightSecondaryColor = Color(0x8FF5C59D);
  static const textFieldGray = Color(0xFFEFEFF4);
  static const greyTextColor = Color(0xff7e848d);
  static const titleMediumColor = Color(0xff7C838D);
  static const darkGreyTextColor = Color(0xFF7D848D);
  static const onboardingGrey = Color(0xfff5f5f5);
  static const borderColor = Color(0xffE5E5E5);
  static const pinCodeColor = Color(0xfff6f6f8);
  static const hintTextColor = Color(0xF0666666);
  static const blackColor = Color(0xff2E323E);
  static const blackTextColor = Color(0xFF1B1E28);
  static const appBarTextColor = Color(0xFF1B1E28);
  static const iconColor = Color(0xff8395B9);
  static const darkBlue = Color(0xff2A384D);
  static const holdSeatColor = Color(0xFFAEBAD2);
  static const green = Color(0xFF24A604);
  static const liteWhite = Color(0xFFC7C7C7);
  static const loginGrey = Color(0xFF8A8A8F);
}

ThemeData appTheme(Locale locale) {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.primaryTextColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primaryTextColor,
      surfaceTint: Colors.black,
      surface: Colors.white,
      secondary: AppColors.secondaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondaryColor,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.secondaryColor,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.borderColor,
    ),
  );
}
