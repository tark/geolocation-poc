import 'package:flutter/material.dart';
import 'package:geolocation_poc/util/context_extensions.dart';

const _min = 0.0;
const _max = 1.0;
const _strokeWidth = 2;
const _maxSize = 400;
const _animationTime = 5;

class AnimatedCircle extends StatefulWidget {
  const AnimatedCircle({super.key});

  @override
  State<AnimatedCircle> createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: _animationTime,
      ),
    )..addListener(() {
        if (_controller.isCompleted) {
          _controller.repeat();
        }
      });

    _animation = Tween<double>(
      begin: _min,
      end: _max,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final value1 = _animation.value;
          final value2 = (value1 + _max * (1 / 3)) % _max;
          final value3 = (value1 + _max * (2 / 3)) % _max;
          return Stack(
            alignment: Alignment.center,
            children: [
              _circle(value1),
              _circle(value2),
              _circle(value3),
            ],
          );
        },
      ),
    );
  }

  Widget _circle(double value) {
    return Container(
      width: value * _maxSize,
      height: value * _maxSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: context.accent.withOpacity(1 - value),
          width: (1 - value) * _strokeWidth,
        ),
      ),
    );
  }
}
