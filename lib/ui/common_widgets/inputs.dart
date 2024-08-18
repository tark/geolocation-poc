import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ui_constants.dart';

const _defaultTextColor = Colors.black;
const _defaultTextLinkColorDisabled = Colors.black54;
const _defaultTextSize = AppSize.fontRegular;
const _defaultFontWeight = FontWeight.w500;
const _defaultFillColor = Colors.white;
const _defaultPaddingVertical = 14.0;
const _defaultPaddingHorizontal = 14.0;
const _defaultBorderColor = Colors.black;
const _defaultBorderColorFocused = Colors.black;
const _defaultBorderColorDisabled = Colors.grey;
const _defaultBorderColorError = Colors.red;
const _defaultBorderRadius = 3.0;
const _defaultBorderWidth = 1.0;
const _defaultBorderWidthFocused = 1.0;
const _defaultHintColor = Colors.black26;

class Inputs extends StatelessWidget {
  //
  final Color? color;
  final double? textSize;
  final bool? isCenter;
  final bool? isRight;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? height;
  final double? letterSpacing;
  final bool? capitalize;
  final TextDecoration? decoration;
  final bool? showShadow;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final Color borderColor;
  final Color borderColorFocused;
  final double borderWidth;
  final double borderWidthFocused;
  final double borderRadius;
  final String? hint;
  final double paddingVertical;
  final double paddingHorizontal;
  final Color hintColor;
  final bool? error;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool outlined;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;

  //
  const Inputs({
    this.color,
    this.textSize,
    this.isCenter = false,
    this.isRight = false,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    this.height,
    this.letterSpacing,
    this.capitalize,
    this.decoration,
    this.showShadow = false,
    this.onChanged,
    this.fillColor,
    this.borderColor = _defaultBorderColor,
    this.borderColorFocused = _defaultBorderColorFocused,
    this.borderWidth = _defaultBorderWidth,
    this.borderWidthFocused = _defaultBorderWidthFocused,
    this.borderRadius = _defaultBorderRadius,
    this.hint,
    this.paddingVertical = _defaultPaddingVertical,
    this.paddingHorizontal = _defaultPaddingHorizontal,
    this.hintColor = _defaultHintColor,
    this.error,
    this.obscureText,
    this.keyboardType,
    this.suffixIcon,
    this.controller,
    this.outlined = false,
    this.focusNode,
    this.textInputAction,
    this.onSubmitted,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
      fontSize: textSize ?? _defaultTextSize,
      color: color ?? _defaultTextColor,
      fontWeight: fontWeight ?? _defaultFontWeight,
      height: height,
      fontFamily: 'Graphik',
      letterSpacing: letterSpacing,
      shadows: showShadow == true
          ? [
              const Shadow(
                offset: Offset(1, 1),
                blurRadius: 0,
                color: Color.fromARGB(60, 0, 0, 0),
              )
            ]
          : null,
    );

    return TextField(
      focusNode: focusNode,
      autocorrect: false,
      enableSuggestions: false,
      controller: controller,
      textCapitalization: capitalize == true
          ? TextCapitalization.sentences
          : TextCapitalization.none,
      textAlign: (isCenter ?? false)
          ? TextAlign.center
          : ((isRight ?? false) ? TextAlign.right : TextAlign.left),
      maxLines: (obscureText ?? false) ? 1 : maxLines,
      //style: _fontStyle(style),
      style: style,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        filled: fillColor != null,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: TextStyle(
          color: hintColor,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
        focusedBorder: _border(
          color: error == true ? _defaultBorderColorError : borderColorFocused,
          width: borderWidthFocused,
        ),
        enabledBorder: _border(
          color: error == true ? _defaultBorderColorError : borderColor,
          width: error == true ? borderWidthFocused : borderWidth,
        ),
        isDense: true,
      ),
    );
  }

  InputBorder _border({
    Color color = _defaultBorderColor,
    double width = _defaultBorderWidth,
  }) {
    return outlined
        ? OutlineInputBorder(
            borderSide: BorderSide(
              color: color,
              width: width,
            ),
          )
        : UnderlineInputBorder(
            borderSide: BorderSide(
              color: color,
              width: width,
            ),
          );
  }
}
