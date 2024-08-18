import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocation_poc/util/context_extensions.dart';

class MyAnimatedIcon extends StatefulWidget {
  const MyAnimatedIcon({
    Key? key,
    this.icon,
    this.child,
    this.color,
    this.size,
  }) : super(key: key);

  final Widget? child;
  final IconData? icon;
  final Color? color;
  final double? size;

  @override
  State<MyAnimatedIcon> createState() => _MyAnimatedIconState();
}

class _MyAnimatedIconState extends State<MyAnimatedIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.icon != null
            ? Icon(
                widget.icon,
                size: widget.size ?? 50.0,
                color: widget.color ?? context.primary,
              )
            : (widget.child ?? Container()),
      ),
    );
  }
}
