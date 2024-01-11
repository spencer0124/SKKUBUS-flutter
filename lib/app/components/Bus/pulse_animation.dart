import 'package:flutter/material.dart';

class PulseAnimation extends StatefulWidget {
  final Widget child;
  final Color color; // Color parameter

  const PulseAnimation(
      {Key? key,
      required this.child,
      required this.color // Initialize the color
      })
      : super(key: key);

  @override
  _PulseAnimationState createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation; // Animation for color

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    // ColorTween animation from the specified color to a transparent version
    _colorAnimation = ColorTween(
            begin: widget.color,
            end: widget.color.withOpacity(0) // Make color transparent
            )
        .animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (_, child) {
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
              _colorAnimation.value ?? widget.color, // Apply the animated color
              BlendMode.srcATop),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
