import 'package:flutter/material.dart';
import 'package:skkumap/app/components/mainpage/busrow.dart';
import 'package:skkumap/app/components/mainpage/middle_snappingsheet/stationrow.dart';
import 'package:skkumap/app_theme.dart';

class OptionCampus extends StatelessWidget {
  const OptionCampus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            // Obx(
            //   () => CustomRow2(
            //     isLoading: controller.jonroLoadingDone.value,
            //     iconData: Icons.stop_circle_rounded,
            //     titleText: '혜화역 1번 출구',
            //     subtitleText1: controller.jonro07BusMessageVisible.value == true
            //         ? controller.jongro07BusMessage.value
            //         : '${controller.jongro07BusRemainStation.value}번째 전 (${controller.jongro07BusRemainTotalTimeSec.value ~/ 60}분 ${controller.jongro07BusRemainTotalTimeSec.value % 60}초)',
            //     subtitleText2: controller.hsscBusMessage.value,
            //     containerColor: Colors.black,
            //     containerText: '정류장',
            //     routeName: '/busData',
            //   ),
            // ),
            const CustomRow1(
              iconData: Icons.directions_bus,
              titleText: '설 연휴 귀향/귀경 버스 (자과캠)',
              subtitleText: '지역별 왕복 운영',
              containerColor: AppColors.green_main,
              containerText: '성대',
              routeName: '/knewyear',
            ),
            const CustomRow1(
              iconData: Icons.directions_bus,
              titleText: '인사캠 셔틀',
              subtitleText: '정차소(인문.농구장) ↔ 600주년 기념관',
              containerColor: AppColors.green_main,
              containerText: '성대',
              routeName: '/busData',
            ),
            const CustomRow1(
              iconData: Icons.directions_bus,
              titleText: '인자셔틀',
              subtitleText: '인사캠 ↔ 자과캠',
              containerColor: AppColors.green_main,
              containerText: '성대',
              routeName: '/eskara',
            ),
            CustomRow1(
              iconData: Icons.directions_bus,
              titleText: '종로 07',
              subtitleText: '명륜새마을금고 ↔ 명륜새마을금고',
              containerColor: Colors.green[400]!,
              containerText: '마을',
              routeName: '/jonromain',
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
