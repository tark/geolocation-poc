import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocation_poc/ui/ui_constants.dart';

import '../common_widgets/buttons.dart';
import '../common_widgets/spinner.dart';
import '../common_widgets/texts.dart';

const _defaultHeight = 42.0;

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key? key,
    required this.text,
    this.leading,
    this.leadingIcon,
    this.leadingIconData,
    this.leadingIconDataSize,
    this.trailing,
    this.trailingIcon,
    this.trailingIconData,
    this.trailingIconDataSize,
    this.onPressed,
    this.color,
    this.height,
    this.error = false,
    this.progress = false,
  }) : super(key: key);

  final Widget? leading;
  final String? leadingIcon;
  final IconData? leadingIconData;
  final double? leadingIconDataSize;
  final Widget? trailing;
  final String? trailingIcon;
  final IconData? trailingIconData;
  final double? trailingIconDataSize;
  final String text;
  final VoidCallback? onPressed;
  final Color? color;
  final double? height;
  final bool error;
  final bool progress;

  @override
  Widget build(BuildContext context) {
    final errorColor = Theme.of(context).colorScheme.error;
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: progress
          ? SizedBox(
              height: height ?? _defaultHeight,
              width: height ?? _defaultHeight,
              child: Spinner(
                color: color ?? (error ? errorColor : secondaryColor),
                size: 14,
              ),
            )
          : Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.03),
                highlightColor: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.05),
                onTap: onPressed,
                child: SizedBox(
                  height: height ?? 42,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (leading != null)
                        Padding(
                          padding: AppPadding.rightSmall,
                          child: leading!,
                        ),
                      if (leadingIconData != null)
                        Padding(
                          padding: const AppPadding.right(8),
                          child: Icon(
                            leadingIconData,
                            color:
                                color ?? (error ? errorColor : secondaryColor),
                            size: leadingIconDataSize ?? 16,
                          ),
                        ),
                      if (leadingIcon != null)
                        Padding(
                          padding: AppPadding.rightSmall,
                          child: SvgPicture.asset(
                            leadingIcon!,
                            color:
                                color ?? (error ? errorColor : secondaryColor),
                          ),
                        ),
                      Texts(
                        text,
                        color: color ?? (error ? errorColor : secondaryColor),
                        fontWeight: FontWeight.w500,
                      ),
                      if (trailing != null)
                        Padding(
                          padding: AppPadding.leftSmall,
                          child: trailing!,
                        ),
                      if (trailingIconData != null)
                        Padding(
                          padding: const AppPadding.left(8),
                          child: Icon(
                            trailingIconData,
                            color:
                            color ?? (error ? errorColor : secondaryColor),
                            size: trailingIconDataSize ?? 16,
                          ),
                        ),
                      if (trailingIcon != null)
                        Padding(
                          padding: AppPadding.leftSmall,
                          child: SvgPicture.asset(
                            trailingIcon!,
                            color:
                            color ?? (error ? errorColor : secondaryColor),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
