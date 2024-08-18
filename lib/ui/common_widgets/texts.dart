import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../ui_constants.dart';
import 'package:geolocation_poc/util/context_extensions.dart';

const _defaultTextLinkColorDisabled = Colors.white30;
const _defaultTextSize = AppSize.fontRegular;
const _defaultFontWeight = FontWeight.w400;
const _defaultMaxLines = 1;
const _defaultTextOverflow = TextOverflow.ellipsis;

class Texts extends StatelessWidget {
  const Texts(
    this.text, {
    this.color,
    this.linkColor,
    this.fontSize,
    this.isCenter = false,
    this.isRight = false,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    this.height,
    this.letterSpacing,
    this.capitalize,
    this.onPressed,
    this.isLink = false,
    this.richText,
    this.decoration,
    this.isBlue = false,
    this.showShadow = false,
    this.gradient,
  });

  const Texts.title(
    final String? text, {
    Color? color,
    Color? linkColor,
    double? textSize,
    bool? isCenter,
    bool? isRight,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    int? maxLines,
    double? height,
    double? letterSpacing,
    bool? capitalize,
    VoidCallback? onPressed,
    bool? isLink,
    List<RichTextData>? richTextDatas,
    TextDecoration? decoration,
    bool? isBlue,
    bool? showShadow,
  }) : this(
          text,
          color: color,
          linkColor: linkColor,
          fontSize: AppSize.fontNormal,
          isCenter: isCenter,
          isRight: isRight,
          fontWeight: FontWeight.w600,
          overflow: overflow,
          maxLines: maxLines,
          height: height,
          letterSpacing: letterSpacing,
          capitalize: capitalize,
          onPressed: onPressed,
          isLink: isLink,
          richText: richTextDatas,
          decoration: decoration,
          isBlue: isBlue,
          showShadow: showShadow,
        );

  //
  final String? text;
  final Color? color;
  final Color? linkColor;
  final double? fontSize;
  final bool? isCenter;
  final bool? isRight;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? height;
  final double? letterSpacing;
  final bool? capitalize;
  final VoidCallback? onPressed;
  final bool? isLink;
  final List<RichTextData>? richText;
  final TextDecoration? decoration;
  final bool? isBlue;
  final bool? showShadow;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    var color = this.color ?? context.primary;

    if (isLink ?? false) {
      color = onPressed == null
          ? _defaultTextLinkColorDisabled
          : linkColor ?? context.accent;
    }

    if (richText != null && richText?.isNotEmpty == true) {
      return Text.rich(
        TextSpan(
          children: (richText ?? [])
              .map(
                (data) => TextSpan(
                  text: data.text,
                  style: TextStyle(
                    fontSize: data.size ?? fontSize ?? _defaultTextSize,
                    color: data.color ?? color,
                    fontWeight:
                        data.fontWeight ?? fontWeight ?? _defaultFontWeight,
                    height: height,
                  ),
                ),
              )
              .toList(),
        ),
        textAlign: (isCenter ?? false)
            ? TextAlign.center
            : ((isRight ?? false) ? TextAlign.right : TextAlign.left),
      );
    }

    var style = TextStyle(
      fontSize: fontSize ?? _defaultTextSize,
      color: color,
      fontWeight: fontWeight ?? _defaultFontWeight,
      height: height,
      letterSpacing: letterSpacing,
      decoration: decoration,
      decorationThickness: 2,
      shadows: (showShadow ?? false)
          ? [
              const Shadow(
                offset: Offset(1, 1),
                blurRadius: 0,
                color: Color.fromARGB(60, 0, 0, 0),
              ),
            ]
          : null,
    );

    if (isLink ?? false) {
      return GestureDetector(
        onTap: onPressed,
        child: Text.rich(
          TextSpan(
            text: capitalize == true ? text?.toUpperCase() : text,
            style: style,
          ),
          textAlign: (isCenter ?? false)
              ? TextAlign.center
              : ((isRight ?? false) ? TextAlign.right : TextAlign.left),
          overflow: overflow,
          maxLines: maxLines,
        ),
      );
    }

    final textWidget = Text(
      (capitalize == true ? text?.toUpperCase() : text) ?? '',
      textAlign: (isCenter ?? false)
          ? TextAlign.center
          : ((isRight ?? false) ? TextAlign.right : TextAlign.left),
      overflow: overflow ?? _defaultTextOverflow,
      maxLines: maxLines ?? _defaultMaxLines,
      style: style,
    );

    final localGradient = gradient;
    if (localGradient != null) {
      return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => localGradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: textWidget,
      );
    }

    return textWidget;
  }
}

class RichTextData {
  final String? text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? size;

  RichTextData(
    this.text, {
    this.color,
    this.fontWeight,
    this.size,
  });

  RichTextData.grey(
    this.text, {
    this.fontWeight,
    this.size,
  }) : color = Colors.black54;

  RichTextData.greySmall(
    this.text, {
    this.fontWeight,
  })  : color = Colors.black54,
        this.size = AppSize.fontSmall;

  RichTextData.blue(
    this.text, {
    this.fontWeight,
    this.size,
  }) : color = Colors.blue;

  RichTextData.blueSmall(
    this.text, {
    this.fontWeight,
  })  : color = Colors.blue,
        size = AppSize.fontSmall;

  RichTextData.greyLight(
    this.text, {
    this.fontWeight,
    this.size,
  }) : color = Colors.white24;

  RichTextData.green(
    this.text, {
    this.fontWeight,
    this.size,
  }) : color = AppColors.green;

  RichTextData.greenLight(
    this.text, {
    this.fontWeight,
    this.size,
  }) : color = AppColors.green.withOpacity(0.4);

  RichTextData.red(
    this.text, {
    this.fontWeight,
    this.size,
  }) : color = Colors.red;

  RichTextData.redLight(
    this.text, {
    this.fontWeight,
    this.size,
  }) : color = Colors.red.withOpacity(0.4);

  RichTextData.bold(
    this.text, {
    this.size,
    this.color,
  })  :
        fontWeight = FontWeight.bold;

  RichTextData.light(
    this.text, {
    this.size,
    this.color,
  })  :
        fontWeight = FontWeight.w300;
}
