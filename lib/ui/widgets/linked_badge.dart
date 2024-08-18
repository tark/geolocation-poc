import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../ui_constants.dart';
import '../common_widgets/texts.dart';

class LinkedBadge extends StatelessWidget {
  const LinkedBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      alignment: Alignment.center,
      padding: AppPadding.horizontalSmall,
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AppImages.linkedIcon),
          const Horizontal.micro(),
          Texts(
            'linked'.tr(),
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 11,
          )
        ],
      ),
    );
  }
}
