import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../util/log.dart';
import '../ui_constants.dart';

class BottomButtonWidget extends StatelessWidget {
  const BottomButtonWidget({
    Key? key,
    required this.bottomWidget,
    required this.content,
  }) : super(key: key);

  final Widget bottomWidget;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: AppPadding.bottomBig,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  content,
                ],
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: bottomWidget,
            ),
          ],
        );
      },
    );
  }
}
