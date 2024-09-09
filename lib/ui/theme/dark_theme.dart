import 'package:flutter/material.dart';

import '../ui_constants.dart';

const fontFamily = 'Roboto';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColorsDarkTheme.background,
  brightness: Brightness.dark,
  chipTheme: ChipThemeData(
    backgroundColor: AppColorsDarkTheme.cardBackground,
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
      color: Colors.grey,
    ),
  ),
  fontFamily: fontFamily,
  primarySwatch: Colors.blue,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.black,
  ),
  iconTheme: const IconThemeData(
    color: AppColorsDarkTheme.text,
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColorsDarkTheme.text.withOpacity(0.1),
      ),
    ),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColorsDarkTheme.text,
    onPrimary: AppColorsDarkTheme.background,
    primaryContainer: AppColorsDarkTheme.textSecondary,
    secondary: AppColorsDarkTheme.blue,
    secondaryContainer: AppColorsDarkTheme.blueSecondary,
    onSecondary: AppColorsDarkTheme.text,
    background: AppColorsDarkTheme.background,
    onBackground: AppColorsDarkTheme.text,
    error: AppColorsDarkTheme.red,
    onError: AppColorsDarkTheme.text,
    surface: AppColorsDarkTheme.background,
    onSurface: AppColorsDarkTheme.text,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: const TextStyle(
      color: AppColorsDarkTheme.text,
    ),
    // subtitle: TextStyle(
    //   fontFamily: fontFamily,
    //   fontSize: 14,
    //   fontWeight: FontWeight.w400,
    //   color: AppColorsDarkTheme.text,
    // ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColorsDarkTheme.background,
    selectedItemColor: AppColorsDarkTheme.blue,
    unselectedItemColor: AppColorsDarkTheme.textSecondary,
    unselectedLabelStyle: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
    selectedLabelStyle: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
    ),
  ),
  cardColor: AppColorsDarkTheme.cardBackground,
  dialogBackgroundColor: AppColorsDarkTheme.background,
  tooltipTheme: TooltipThemeData(
    padding: AppPadding.horizontalMedium +
        AppPadding.verticalSmall +
        AppPadding.bottomMicro,
    margin: AppPadding.allNormal,
    textStyle: const TextStyle(
      fontSize: AppSize.fontRegular,
      height: 1.5,
      fontWeight: FontWeight.w500,
      color: AppColorsDarkTheme.background,
    ),
    decoration: BoxDecoration(
      color: AppColorsDarkTheme.text.withOpacity(0.85),
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
    ),
  ),
);
