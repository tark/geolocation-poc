import 'package:flutter/material.dart';

import '../ui/ui_constants.dart';

extension ContextExtention on BuildContext {
  Color get background => Theme.of(this).colorScheme.background;

  Color get scaffoldBackground => Theme.of(this).scaffoldBackgroundColor;

  Color get primary => Theme.of(this).colorScheme.primary;

  Color get secondary => Theme.of(this).colorScheme.primaryContainer;

  Color get accent => Theme.of(this).colorScheme.secondary;

  Color get accentSecondary => Theme.of(this).colorScheme.secondaryContainer;

  Color get error => Theme.of(this).colorScheme.error;

  Color get cardBackground => Theme.of(this).cardColor;

  Color get dialogBarrier =>
      isDark ? AppColorsDarkTheme.dialogBarrier : AppColors.dialogBarrier;

  Color get dialogBarrierStatusBar => isDark
      ? AppColorsDarkTheme.dialogBarrierStatusBar
      : AppColors.dialogBarrierStatusBar;

  Color get checkInExternalBackground => isDark
      ? AppColorsDarkTheme.checkInExternalBackground
      : AppColors.checkInExternalBackground;

  Color get checkInExternalCardBackground => isDark
      ? AppColorsDarkTheme.checkInExternalCardBackground
      : AppColors.checkInExternalCardBackground;

  Color get checkInExternalInfoTitle => isDark
      ? AppColorsDarkTheme.checkInExternalInfoTitle
      : AppColors.checkInExternalInfoTitle;

  Color get buttonText =>
      isDark ? AppColorsDarkTheme.buttonText : AppColors.buttonText;

  Color get buttonSecondary =>
      isDark ? AppColorsDarkTheme.buttonSecondary : AppColors.buttonSecondary;

  bool get isLight => !isDark;

  bool get isDark => false;

  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;

  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;

  void popUntilFirstScreen() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }
}
