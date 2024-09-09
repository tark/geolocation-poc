import 'package:flutter/material.dart';

import '../ui_constants.dart';
import 'buttons.dart';
import 'texts.dart';

class ScreenPlaceholder extends StatelessWidget {
  const ScreenPlaceholder({
    Key? key,
    required this.title,
    required this.icon,
    this.dark = false,
    this.color,
    this.action,
    this.actionText,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final bool dark;
  final Color? color;
  final String? actionText;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color ??
                (dark
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.15)
                    : Theme.of(context).colorScheme.primary.withOpacity(0.2)),
            size: 40,
          ),
          const Vertical.normal(),
          Padding(
            padding: AppPadding.horizontalHuge,
            child: Texts(
              title,
              fontWeight: FontWeight.w600,
              color: color ??
                  (dark
                      ? Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.15)
                      : Theme.of(context).colorScheme.primary.withOpacity(0.2)),
              fontSize: AppSize.fontNormal,
              isCenter: true,
              maxLines: 3,
            ),
          ),
          if (action != null)
            Padding(
              padding: AppPadding.topBig + AppPadding.horizontalHuge,
              child: Buttons(
                text: actionText,
                onPressed: action,
              ),
            )
        ],
      ),
    );
  }
}
