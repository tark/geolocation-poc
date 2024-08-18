import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  Color darken(double percent) {
    if (percent > 1 || percent < 0) {
      throw Exception("Percent must be between 0 and 1");
    }

    var hsv = HSVColor.fromColor(this);
    hsv = hsv.withValue(hsv.value * (1 - percent));
    return hsv.toColor();
  }
}
