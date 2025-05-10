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
              text: '음식점'.tr,
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
              text: '카페'.tr,
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
              text: '술집'.tr,
              icon: Icons.sensor_occupied_sharp,
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
              text: '새로오픈'.tr,
              icon: Icons.sensor_occupied_sharp,
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
              text: '더보기'.tr,
              icon: Icons.sensor_occupied_sharp,
              ischecked: false,
            ),
          ),
        ],
      ),
    );
  }
}
