import 'package:flutter/material.dart';
import 'package:skkumap/app/types/bus_type.dart';

class PulseAnimation extends StatefulWidget {
  final BusType busType;

  const PulseAnimation({
    Key? key,
    required this.busType,
  }) : super(key: key);

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
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // Pulse animation
        AnimatedBuilder(
          animation: _animation,
          builder: (_, child) {
            return Opacity(
              opacity: (1 - _animation.value / 1.7),
              child: Transform.scale(
                scale: _animation.value,
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.busType.color,
                  ),
                ),
              ),
            );
          },
        ),
        // Circle and Icon in the foreground
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.busType.color,
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.directions_bus,
            size: 25 / 2,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
