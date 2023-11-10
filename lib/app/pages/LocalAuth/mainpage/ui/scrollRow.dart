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
            width: 5,
          ),
          const ScrollRowContainer(
            text: '종로07 위치',
            icon: Icons.location_on_rounded,
            ischecked: true,
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Get.toNamed('/injadetail');
            },
            child: const ScrollRowContainer(
              text: '인자셔틀 탑승장소',
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
              Get.toNamed('/busDetail');
            },
            child: const ScrollRowContainer(
              text: '인사캠셔틀 노선',
              icon: Icons.map_outlined,
              ischecked: false,
            ),
          ),
          // Add more containers as needed
        ],
      ),
    );
  }
}
