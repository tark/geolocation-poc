import 'package:flutter/material.dart';
import 'package:geolocation_poc/ui/ui_constants.dart';

import 'confirm_view.dart';

class MyModal extends StatelessWidget {
  const MyModal({
    Key? key,
    required this.title,
    this.message,
    this.confirmText,
    this.cancelText,
    this.showConfirmOnly = false,
    this.child,
  }) : super(key: key);

  final String title;
  final String? message;
  final String? confirmText;
  final String? cancelText;
  final bool showConfirmOnly;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const AppPadding.all(20),
      content: ConfirmView(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        showConfirmOnly: showConfirmOnly,
        child: child,
      ),
    );
  }
}
