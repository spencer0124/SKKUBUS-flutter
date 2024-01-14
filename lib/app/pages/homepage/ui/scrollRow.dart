import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'scrollRowComponent.dart'; // Import the ScrollRowContainer widget

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
          const ScrollRowContainer(
            text: '인사캠',
            icon: Icons.location_on_rounded,
            ischecked: true,
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // Get.toNamed('/injadetail');
            },
            child: const ScrollRowContainer(
              text: '인사캠 건물',
              icon: Icons.location_on_rounded,
              ischecked: false,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // Get.toNamed('/injadetail');
            },
            child: const ScrollRowContainer(
              text: '자과캠',
              icon: Icons.location_on_rounded,
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
              text: '캠퍼스간 이동',
              icon: Icons.location_on_rounded,
              ischecked: false,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          // GestureDetector(
          //   behavior: HitTestBehavior.translucent,
          //   onTap: () {
          //     Get.toNamed('/pageroute');
          //   },
          //   child: const ScrollRowContainer(
          //     text: 'dummy',
          //     icon: Icons.battery_charging_full_outlined,
          //     ischecked: false,
          //   ),
          // ),
        ],
      ),
    );
  }
}
