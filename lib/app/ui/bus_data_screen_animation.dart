import 'package:flutter/material.dart';
// Replace with your actual import

class PulseAnimation extends StatefulWidget {
  final Widget child;

  const PulseAnimation({Key? key, required this.child}) : super(key: key);

  @override
  _PulseAnimationState createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation = Tween(begin: 1.0, end: 1.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    )..addStatusListener((status) {
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
      animation: _animation,
      builder: (_, child) {
        return Opacity(
          opacity: (1 - _animation.value / 1.7),
          child: Transform.scale(
            scale: _animation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
