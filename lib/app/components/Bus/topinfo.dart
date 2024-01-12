import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import 'package:skkumap/app/types/bus_status.dart';
import 'package:skkumap/app/types/time_format.dart';

class TopInfo extends StatelessWidget {
  final TimeFormat timeFormat;
  final int busCount;
  final BusStatus busStatus;
  final bool isLoaded;

  const TopInfo({
    Key? key,
    required this.timeFormat,
    required this.busCount,
    required this.busStatus,
    required this.isLoaded,
  }) : super(key: key);

  String get timeString {
    DateFormat formatter = timeFormat == TimeFormat.format12Hour
        ? DateFormat('hh:mm a')
        : DateFormat('HH:mm');
    return formatter.format(DateTime.now());
  }

  String get busCountString {
    return busStatus == BusStatus.active ? "$busCount대 운행 중" : "운행 종료";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      color: Colors.grey[100],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 4.0),
            child: isLoaded
                ? Text(
                    "$timeString 기준 · $busCountString",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[800],
                    ),
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey[100]!,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 200,
                      height: 20,
                      color: Colors.grey,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
