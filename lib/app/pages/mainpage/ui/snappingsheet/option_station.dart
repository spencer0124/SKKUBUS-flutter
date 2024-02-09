import 'package:flutter/material.dart';
import 'package:skkumap/app/components/mainpage/busrow.dart';
import 'package:skkumap/app/components/mainpage/middle_snappingsheet/stationrow.dart';
import 'package:skkumap/app_theme.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/mainpage/controller/mainpage_controller.dart';

class OptionStation extends StatelessWidget {
  OptionStation({Key? key}) : super(key: key);

  final controller = Get.find<MainpageController>();

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
            Obx(
              () => CustomRow2(
                isLoading: true,
                iconData: Icons.stop_circle_rounded,
                titleText: '혜화역 1번 출구',
                subtitleText1:
                    controller.stationData.value?.stationData[0].msg1Message ??
                        "정보 없음",
                subtitleText2:
                    controller.stationData.value?.stationData[1].msg1Message ??
                        "정보 없음",
                containerColor: Colors.black,
                containerText: '정류장',
                routeName: '/MainbusMain',
              ),
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
