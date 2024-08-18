import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocation_poc/ui/ui_constants.dart';
import 'package:geolocation_poc/util/context_extensions.dart';

import '../../util/log.dart';
import '../common_widgets/texts.dart';

class MyCheckbox extends StatelessWidget {
  const MyCheckbox({
    Key? key,
    this.title,
    this.child,
    this.error = false,
    this.isCenter = false,
    required this.checked,
    required this.onChanged,
  }) : super(key: key);

  final bool checked;
  final bool error;
  final bool isCenter;
  final String? title;
  final ValueChanged<bool> onChanged;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final textWidget = Texts(
      title,
      fontSize: AppSize.fontRegular,
      color: error ? context.error : context.primary,
      fontWeight: FontWeight.w500,
      maxLines: 100,
      height: 1.5,
    );

    return GestureDetector(
      onTap: () => onChanged(!checked),
      child: Padding(
        padding: AppPadding.verticalSmall,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Padding(
              padding: const AppPadding.top(2),
              child: _icon(context),
            ),
            const Horizontal.small(),
            if (title != null)
              isCenter
                  ? textWidget
                  : Expanded(
                      child: textWidget,
                    ),
            if (child != null) child ?? const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _icon(BuildContext context) {
    String icon;
    if (error) {
      icon = AppImages.checkBoxErrorIcon;
    } else if (context.isDark) {
      icon = checked
          ? AppImages.checkBoxCheckedDarkIcon
          : AppImages.checkBoxDarkIcon;
    } else {
      icon =
      checked ? AppImages.checkBoxCheckedIcon : AppImages.checkBoxIcon;
    }

    return SvgPicture.asset(icon);
  }
}
