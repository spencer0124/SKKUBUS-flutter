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
            child: ScrollRowContainer(
              text: '인사캠 건물지도'.tr,
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
            child: ScrollRowContainer(
              text: '자과캠 건물지도'.tr,
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
              Get.toNamed('/lostandfound');
            },
            child: ScrollRowContainer(
              text: '유실물 찾기'.tr,
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
