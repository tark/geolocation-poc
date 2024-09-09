import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocation_poc/util/context_extensions.dart';

import '../common_widgets/texts.dart';
import '../ui_constants.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    Key? key,
    required this.title,
    this.icon,
    this.iconData,
    this.gray = false,
    this.color,
  }) : super(key: key);

  final String title;
  final String? icon;
  final IconData? iconData;
  final bool gray;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final color = context.checkInExternalInfoTitle;
    return Row(
      children: [
        if (icon != null)
          SvgPicture.asset(
            icon!,
            height: 14,
            width: 14,
            color: color,
          ),
        if (iconData != null)
          FaIcon(
            iconData,
            size: 14,
            color: color,
          ),
        if (icon == null && iconData == null)
          const SizedBox(
            width: 14,
            height: 14,
          ),
        const Horizontal.small(),
        Expanded(
          child: Texts(
            title.isEmpty ? 'Place to be defined' : title,
            fontSize: AppSize.fontRegular,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }
}
