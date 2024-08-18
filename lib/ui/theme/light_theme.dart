import 'package:flutter/material.dart';

import '../ui_constants.dart';

const fontFamily = 'Roboto';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  brightness: Brightness.light,
  chipTheme: ChipThemeData(
    backgroundColor: AppColors.cardBackground,
    elevation: 0,
    labelPadding: const EdgeInsets.only(
      left: 11,
      top: 5,
      bottom: 5,
      right: 11,
    ),
    labelStyle: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppSize.fontNormal,
      fontWeight: FontWeight.w900,
    ),
    secondaryLabelStyle: TextStyle(
      fontFamily: fontFamily,
      fontSize: AppSize.fontNormal,
      fontWeight: FontWeight.w900,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    contentTextStyle: TextStyle(
      fontFamily: fontFamily,
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.red,
    ),
  ),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all(Colors.black12),
    trackBorderColor: MaterialStateProperty.all(Colors.transparent),
    trackColor: MaterialStateProperty.all(Colors.black12),
    trackVisibility: MaterialStateProperty.all(false),
    radius: const Radius.circular(4),
    thickness: MaterialStateProperty.all(2),
  ),
  fontFamily: fontFamily,
  primarySwatch: Colors.blue,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.black,
  ),
  iconTheme: const IconThemeData(
    color: AppColors.text,
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    // primary text color
    primary: AppColors.text,
    // secondary text color
    primaryContainer: AppColors.textSecondary,
    // accent color
    secondary: AppColors.blue,
    background: Colors.white,
    onPrimary: AppColors.green,
    onSecondary: AppColors.green,
    error: AppColors.red,
    onError: AppColors.red,
    onBackground: AppColors.lightBackground,
    surface: Colors.green,
    onSurface: Colors.green,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.text.withOpacity(0.1),
      ),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: AppColors.lightBackground,
    selectedItemColor: AppColors.blue,
    unselectedItemColor: AppColors.textSecondary,
    unselectedLabelStyle: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
    selectedLabelStyle: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
    ),
  ),
  cardColor: AppColors.cardBackground,
  tooltipTheme: TooltipThemeData(
    padding: AppPadding.horizontalMedium +
        AppPadding.verticalSmall +
        AppPadding.bottomMicro,
    margin: AppPadding.allNormal,
    textStyle: const TextStyle(
      fontSize: AppSize.fontRegular,
      height: 1.5,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    decoration: BoxDecoration(
      color: AppColors.text.withOpacity(0.85),
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
    ),
  ),
);
