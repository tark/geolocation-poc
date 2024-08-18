import 'package:flutter/material.dart';
import 'package:geolocation_poc/util/context_extensions.dart';

import '../ui_constants.dart';

class StepsIndicator extends StatelessWidget {
  const StepsIndicator({
    Key? key,
    this.stepsCount = 5,
    required this.step,
  }) : super(key: key);

  final int stepsCount;
  final int step;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        stepsCount,
        (i) => Expanded(
          child: Padding(
            padding: const AppPadding.horizontal(0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: SizedBox(
                height: 2,
                child: ColoredBox(
                  color: i <= step ? context.accent : context.primary.withOpacity(0.1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
