import 'package:flutter/material.dart';

import '../ui_constants.dart';

class Spinner extends StatelessWidget {
  const Spinner({
    Key? key,
    this.size,
    this.color,
    this.progress,
    this.strokeWidth,
  }) : super(key: key);

  final double? size;
  final Color? color;
  final double? strokeWidth;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size ?? 24,
        height: size ?? 24,
        child: CircularProgressIndicator(
          value: progress,
          color: color ?? Theme.of(context).colorScheme.secondary,
          strokeWidth: strokeWidth ?? 2,
        ),
      ),
    );
  }
}
