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
              text: '건물지도',
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
              // Get.toNamed('/hsscbuildingmap');
            },
            child: const ScrollRowContainer(
              text: '캠퍼스 이동',
              icon: Icons.transfer_within_a_station_sharp,
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
              text: '혜화 맛집',
              icon: Icons.dining_rounded,
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
              text: '버스 분실물',
              icon: Icons.bus_alert,
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
