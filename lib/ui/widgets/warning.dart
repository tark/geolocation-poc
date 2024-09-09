import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocation_poc/util/context_extensions.dart';

import '../common_widgets/texts.dart';
import '../ui_constants.dart';

class Warning extends StatelessWidget {
  const Warning({
    Key? key,
    required this.title,
    this.hideBorder = false,
    this.isCenter = false,
  }) : super(key: key);

  final String title;
  final bool hideBorder;
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.horizontalMedium + AppPadding.verticalSmall,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: hideBorder ? Colors.transparent : context.error,
          width: hideBorder ? 0 : 1,
        ),
      ),
      child: Row(
        mainAxisAlignment:
            isCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Padding(
            padding: AppPadding.verticalMicro,
            child: FaIcon(
              FontAwesomeIcons.triangleExclamation,
              color: context.error,
              size: 16,
            ),
          ),
          const Horizontal.medium(),
          if (isCenter)
            Texts(
              title,
              fontWeight: FontWeight.w500,
              color: context.error,
              maxLines: 10,
              height: 1.4,
            )
          else
            Expanded(
              child: Texts(
                title,
                fontWeight: FontWeight.w500,
                color: context.error,
                maxLines: 10,
                height: 1.4,
              ),
            ),
        ],
      ),
    );
  }
}
