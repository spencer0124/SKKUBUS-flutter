import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'scrollrow_component.dart'; // Import the ScrollRowContainer widget

class ScrollableRow extends StatelessWidget {
  const ScrollableRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none, // 그림자가 제대로 표시되지 않는 문제 해결
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
              svgPath: 'assets/tossface/toss_forkandknife.svg',
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
              svgPath: 'assets/tossface/toss_coffee.svg',
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
              svgPath: 'assets/tossface/toss_beer.svg',
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
              svgPath: 'assets/tossface/toss_arrow2_up.svg',
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
              svgPath: 'assets/tossface/toss_plus.svg',
              ischecked: false,
            ),
          ),
        ],
      ),
    );
  }
}
