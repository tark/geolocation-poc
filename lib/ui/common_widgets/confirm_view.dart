import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocation_poc/ui/ui_constants.dart';
import 'package:geolocation_poc/util/context_extensions.dart';

import 'buttons.dart';
import 'texts.dart';

class ConfirmView extends StatelessWidget {
  const ConfirmView({
    Key? key,
    required this.title,
    this.message,
    this.confirmText,
    this.confirmIcon,
    this.cancelText,
    this.cancelIcon,
    this.showConfirmOnly = false,
    this.child,
    this.danger = false,
    this.alignCenter = false,
  }) : super(key: key);

  final String title;
  final String? message;
  final String? confirmText;
  final IconData? confirmIcon;
  final String? cancelText;
  final IconData? cancelIcon;
  final bool showConfirmOnly;
  final Widget? child;
  final bool danger;
  final bool alignCenter;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: AppPadding.verticalSmall,
          child: Texts(
            title,
            fontSize: AppSize.fontNormal,
            fontWeight: FontWeight.w500,
            maxLines: 10,
            isCenter: true,
            height: 1.5,
          ),
        ),
        if (message != null)
          Padding(
            padding: AppPadding.verticalNormal + AppPadding.horizontalMicro,
            child: Padding(
              padding: AppPadding.allMicro,
              child: Texts(
                message,
                maxLines: 1000,
                fontWeight: FontWeight.w500,
                height: 1.5,
                isCenter: alignCenter,
              ),
            ),
          ),
        if (child != null) child!,
        Padding(
          padding: AppPadding.topNormal,
          child: Row(
            children: [
              if (!showConfirmOnly)
                Expanded(
                  child: Buttons.flat(
                    text: cancelText ?? 'cancel'.tr(),
                    buttonColor: danger ? context.secondary.withOpacity(0.1) : context.error,
                    textColor: danger ? context.primary : null,
                    iconData: cancelIcon ?? Icons.close,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ),
              if (!showConfirmOnly)
                const Padding(
                  padding: AppPadding.right(10),
                ),
              Expanded(
                child: Buttons.flat(
                  text: confirmText ?? 'ok'.tr(),
                  buttonColor: danger ? context.error : context.accent,
                  iconData: confirmIcon ?? Icons.check,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
