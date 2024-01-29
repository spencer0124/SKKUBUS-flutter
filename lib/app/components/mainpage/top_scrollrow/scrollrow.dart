import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'scrollrow_component.dart'; // Import the ScrollRowContainer widget

class ScrollableRow extends StatelessWidget {
  const ScrollableRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Get.toNamed('/hsscbuildingmap');
            },
            child: const ScrollRowContainer(
              text: '인사캠 건물지도',
              icon: Icons.outbond,
              ischecked: false,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Get.toNamed('/nscbuildingmap');
            },
            child: const ScrollRowContainer(
              text: '자과캠 건물지도',
              icon: Icons.outbond,
              ischecked: false,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // Get.toNamed('/busDetail');
            },
            child: const ScrollRowContainer(
              text: '유실물찾기',
              icon: Icons.sensor_occupied_sharp,
              ischecked: false,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
