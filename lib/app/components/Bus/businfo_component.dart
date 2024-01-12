import 'dart:async';
import 'package:flutter/material.dart';
import 'licenseplate.dart';
import 'pulse_animation.dart';
import 'package:skkumap/app/utils/constants.dart';
import 'package:skkumap/app/types/bus_type.dart';

class BusInfoComponent extends StatefulWidget {
  final int elapsedSeconds;
  final int currentStationIndex;
  final int lastStationIndex;
  final String plateNumber;
  final BusType busType;

  const BusInfoComponent({
    Key? key,
    required this.elapsedSeconds,
    required this.currentStationIndex,
    required this.lastStationIndex,
    required this.plateNumber,
    required this.busType,
  }) : super(key: key);

  @override
  State<BusInfoComponent> createState() => _BusInfoComponentState();
}

class _BusInfoComponentState extends State<BusInfoComponent> {
  late int elapsedSecondsOverride;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    elapsedSecondsOverride = widget
        .elapsedSeconds; // Start with the initial elapsed seconds passed in.
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // elapsedSecondsOverride++; // Increment the elapsed seconds.
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Don't forget to cancel the timer.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      /*
      얼마나 버스 아이콘을 이동시킬지 결정한다
      1. 현재 정류장이 마지막 정류장인 경우: 이동시키면 안된다
      2. 현재 정류장이 마지막 정류장이 아닌 경우:
        2-1. 버스가 출발한지 550초가 지난 경우: 이동시키면 안된다
        2-2. 버스가 출발한지 550초가 지나지 않은 경우: 1초에 1/9씩 이동시킨다
      */
      top: widget.currentStationIndex == widget.lastStationIndex
          ? 26 + 66.0 * widget.currentStationIndex
          : elapsedSecondsOverride > 200
              ? 26 + 66.0 * widget.currentStationIndex + 40
              : 26 +
                  66.0 * widget.currentStationIndex +
                  elapsedSecondsOverride / 5,
      left: BusConstants.infoComponentLeftpadding,
      child: Row(
        children: [
          LicensePlate(
            plateNumber: widget.plateNumber,
          ),
          const SizedBox(
            width: 5,
          ),
          PulseAnimation(
            busType: widget.busType,
          ),
        ],
      ),
    );
  }
}
