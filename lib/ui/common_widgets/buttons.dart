import 'package:flutter/material.dart';
import 'package:geolocation_poc/util/context_extensions.dart';

import '../ui_constants.dart';
import 'texts.dart';

const _defaultTextOutlinedColor = Colors.black;
const _defaultTextDisabledColor = Colors.white;
const _defaultTextDisabledOutlinedColor = Colors.black;
const _defaultTextSize = AppSize.fontRegular;
const _defaultButtonHeight = AppSize.buttonHeight;
const _defaultFontWeight = FontWeight.w600;
const _defaultFontWeightDisabled = FontWeight.normal;
const _defaultIconSize = 20.0;
const _defaultProgressWidth = 1.5;
const _defaultBorderWidth = 1.0;
const _defaultBorderRadius = 8.0;

class Buttons extends StatelessWidget {
  const Buttons({
    key,
    this.text,
    this.child,
    this.onPressed,
    this.textColor,
    this.textDisabledColor,
    this.margin = 0.0,
    this.wrapContent = false,
    this.width,
    this.textSize,
    this.height,
    this.progress = false,
    this.progressWidth,
    this.progressColor,
    this.outlined = false,
    this.outlinedGrey = false,
    this.transparent = false,
    this.flat = false,
    this.iconPath,
    this.iconData,
    this.fontWeight,
    this.fontWeightDisabled,
    this.buttonColor,
    this.buttonDisabledColor,
    this.iconTrailing = false,
    this.isRed = false,
    this.caps = false,
    this.borderColor,
    this.iconColor,
    this.padding,
    this.borderRadius,
    this.borderWidth,
    this.showShadow = false,
    this.leading,
    this.secondary = false,
  });

  //
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? textDisabledColor;
  final double? margin;
  final bool wrapContent;
  final double? width;
  final double? textSize;
  final double? height;
  final bool progress;
  final bool outlined;
  final bool outlinedGrey;
  final bool transparent;
  final bool flat;
  final String? iconPath;
  final IconData? iconData;
  final FontWeight? fontWeight;
  final FontWeight? fontWeightDisabled;
  final Color? buttonColor;
  final Color? buttonDisabledColor;
  final bool iconTrailing;
  final bool isRed;
  final bool caps;
  final Color? borderColor;
  final Color? iconColor;
  final Color? progressColor;
  final double? progressWidth;
  final EdgeInsets? padding;
  final double? borderRadius;
  final double? borderWidth;
  final bool showShadow;
  final Widget? leading;
  final bool secondary;

  const Buttons.flat({
    key,
    text,
    iconData,
    onPressed,
    progress = false,
    wrapContent = false,
    buttonColor,
    textColor,
    double? textSize,
    FontWeight? fontWeight,
    double? height,
  }) : this(
          key: key,
          text: text,
          flat: true,
          iconData: iconData,
          onPressed: onPressed,
          buttonColor: buttonColor ?? Colors.white10,
          buttonDisabledColor: Colors.white10,
          progress: progress,
          wrapContent: wrapContent,
          textColor: textColor,
          textSize: textSize,
          fontWeight: fontWeight,
          height: height,
        );

  @override
  Widget build(BuildContext context) {
    if (wrapContent == true && width != null) {
      throw Exception('if width != null, then wrapContent should be false');
    }

    double minWidth;
    if (wrapContent) {
      minWidth = 0.0;
    } else if (width != null) {
      minWidth = width ?? 0;
    } else {
      minWidth = AppSize.buttonWidth;
    }

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? _defaultBorderRadius),
    );
    final child = this.child ?? _content(context);

    Widget button;

    if (outlined) {
      button = OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: padding,
          side: BorderSide(
            width: borderWidth ?? _defaultBorderWidth,
            color: borderColor ?? Theme.of(context).colorScheme.secondary,
            style: BorderStyle.solid,
          ),
          /*backgroundColor: onPressed == null
              ? buttonDisabledColor ?? _defaultButtonDisabledColor
              : buttonColor ?? _defaultButtonOutlinedColor,*/
          shape: shape,
        ),
        key: key,
        onPressed: onPressed,
        child: child,
      );
    } else if (outlinedGrey) {
      button = SizedBox(
        height: height ?? _defaultButtonHeight,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: shape,
            side: BorderSide(
              width: 0.4,
              color: onPressed == null
                  ? (buttonDisabledColor ?? Colors.white24)
                  : (borderColor ?? Colors.white54),
              style: BorderStyle.solid,
            ),
            padding: padding,
            backgroundColor: buttonColor ?? Colors.white10,
          ),
          key: key,
          onPressed: onPressed,
          child: child,
        ),
      );
    } else if (flat) {
      button = TextButton(
        style: TextButton.styleFrom(
          padding: padding,
          backgroundColor: onPressed == null
              ? buttonDisabledColor ?? context.accentSecondary
              : buttonColor ?? context.accent,
          shape: shape,
        ),
        key: key,
        onPressed: onPressed,
        child: child,
      );
    } else if (transparent) {
      button = TextButton(
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: MaterialStateProperty.all(padding),
          backgroundColor: MaterialStateProperty.all(onPressed == null
              ? buttonDisabledColor ?? context.accentSecondary
              : Colors.transparent),
          shape: MaterialStateProperty.all(shape),
          overlayColor:
              MaterialStateColor.resolveWith((states) => Colors.black12),
        ),
        key: key,
        onPressed: onPressed,
        child: child,
      );
    } else if (secondary) {
      button = ElevatedButton(
        key: key,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return context.buttonSecondary.withOpacity(0.5);
              }
              return buttonColor ?? context.buttonSecondary;
            },
          ),
          padding: MaterialStateProperty.all(padding),
          shape: MaterialStateProperty.all(shape),
          elevation: MaterialStateProperty.all(0),
        ),
        onPressed: onPressed,
        child: child,
      );
    } else {
      button = ElevatedButton(
        key: key,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Theme.of(context).colorScheme.secondary.withOpacity(0.5);
              }
              return buttonColor ?? Theme.of(context).colorScheme.secondary;
            },
          ),
          padding: MaterialStateProperty.all(padding),
          shape: MaterialStateProperty.all(shape),
          elevation: MaterialStateProperty.all(0),
        ),
        onPressed: onPressed,
        child: child,
      );
    }

    return ButtonTheme(
      minWidth: minWidth,
      height: height ?? _defaultButtonHeight,
      child: SizedBox(
        width: width,
        height: height ?? _defaultButtonHeight,
        child: button,
      ),
    );
  }

  //
  Widget _content(BuildContext context) {
    List<Widget> widgets;
    Color color;
    if (outlined) {
      if (_disabled()) {
        color = textDisabledColor ?? _defaultTextDisabledOutlinedColor;
      } else {
        color = textColor ?? _defaultTextOutlinedColor;
      }
    } else if (transparent) {
      if (_disabled()) {
        color = textDisabledColor ?? context.primary;
      } else {
        color = textColor ?? context.primary;
      }
    } else if (secondary) {
      if (_disabled()) {
        color = textDisabledColor ?? context.primary;
      } else {
        color = textColor ?? context.primary;
      }
    } else {
      if (_disabled()) {
        color = textDisabledColor ?? _defaultTextDisabledColor;
      } else {
        color = textColor ?? context.buttonText;
      }
    }

    if (progress) {
      widgets = [
        SizedBox(
          width: 16.0,
          height: 16.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeWidth: progressWidth ?? _defaultProgressWidth,
          ),
        )
      ];
    } else {
      final iconByPath = (iconPath != null)
          ? Padding(
              padding: AppPadding.horizontalMicro,
              child: Image(
                image: AssetImage(iconPath ?? ''),
                width: _defaultIconSize,
                height: _defaultIconSize,
                color: iconColor ?? color,
              ),
            )
          : null;

      final iconByData = (iconData != null)
          ? Padding(
              padding: AppPadding.horizontalMicro,
              child: Icon(
                iconData,
                size: _defaultIconSize,
                color: iconColor ?? color,
              ),
            )
          : null;

      widgets = [
        if (iconPath != null && !iconTrailing && iconByPath != null) iconByPath,
        if (iconData != null && !iconTrailing && iconByData != null) iconByData,
        if (leading != null) leading!,
        if (text != null)
          Texts(
            caps ? text?.toUpperCase() : text,
            color: color,
            fontSize: textSize ?? _defaultTextSize,
            fontWeight: onPressed == null
                ? fontWeightDisabled ?? _defaultFontWeightDisabled
                : fontWeight ?? _defaultFontWeight,
            showShadow: showShadow,
            maxLines: 10,
          ),
        if (iconData != null && iconTrailing && iconByData != null) iconByData,
        if (iconPath != null && iconTrailing && iconByPath != null) iconByPath,
      ];
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }

  bool _disabled() {
    return onPressed == null;
  }
}
