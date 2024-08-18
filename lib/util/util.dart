import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocation_poc/util/context_extensions.dart';

import '../ui/common_widgets/texts.dart';
import '../ui/ui_constants.dart';

void showError(BuildContext context, String? error) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    content: Texts(
      error ?? 'Null',
      color: Colors.white,
      fontWeight: FontWeight.w600,
      maxLines: 10,
    ),
    backgroundColor: context.error,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ));
}

void showSuccess(BuildContext context, String? message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    content: Texts(
      message ?? 'Null',
      color: Colors.white,
      fontWeight: FontWeight.w600,
      maxLines: 10,
    ),
    backgroundColor: AppColors.green,
    duration: const Duration(seconds: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ));
}

void showInfo(BuildContext context, String? message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Texts(
      message ?? 'Null',
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    backgroundColor: Colors.blue[700],
    duration: const Duration(seconds: 1),
  ));
}

Future<T?> showBottomModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? background,
}) async {
  final result = await showModalBottomSheet<T>(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    barrierColor: context.dialogBarrier,
    builder: (c) {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        child: ColoredBox(
          color: background ?? context.background,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(c).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: AppPadding.topMedium,
                  child: Container(
                    height: 5,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                builder(c)
              ],
            ),
          ),
        ),
      );
    },
  );
  return result;
}

Future<T?> showTopModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = false,
}) async {
  final result = await showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    transitionDuration: const Duration(milliseconds: 500),
    barrierLabel: MaterialLocalizations.of(context).dialogLabel,
    barrierColor: Colors.black38,
    pageBuilder: (c, _, __) {
      return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: builder(c),
              ),
            ),
          ],
        ),
      );
    },
    transitionBuilder: (c, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ).drive(Tween<Offset>(
          begin: const Offset(0, -1.0),
          end: Offset.zero,
        )),
        child: child,
      );
    },
  );
  return result;
}

Future<T?> showModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) async {
  final result = await showDialog(
    context: context,
    builder: builder,
    barrierColor: !context.isDark ? context.secondary : null,
  );
  return result;
}
