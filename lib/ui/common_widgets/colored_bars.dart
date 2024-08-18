import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocation_poc/util/context_extensions.dart';

class ColoredBars extends StatelessWidget {
  const ColoredBars({
    Key? key,
    required this.child,
    this.navBarColor,
    this.navBarColorBarrier,
    this.statusBarColor,
    this.statusBarColorBarrier,
    this.brightness,
  }) : super(key: key);

  final Widget child;
  final Color? navBarColor;
  final Color? navBarColorBarrier;
  final Color? statusBarColor;
  final Color? statusBarColorBarrier;
  final Brightness? brightness;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? context.background,
        // statusBarBrightness: _brightness(context, state),
        // statusBarIconBrightness: _brightness(context, state),
        systemNavigationBarColor: navBarColor ??
            BottomNavigationBarTheme.of(context).backgroundColor,
        // systemNavigationBarIconBrightness: _brightness(context, state),
      ),
      child: child,
    );
  }

}
