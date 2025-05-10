import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/mainpage/controller/mainpage_controller.dart';
import 'package:skkumap/app/utils/screensize.dart';
import 'package:skkumap/app/pages/mainpage/ui/snappingsheet/option_bus.dart';

// '주변' 탭

class OptionAround extends StatelessWidget {
  OptionAround({Key? key}) : super(key: key);

  final controller = Get.find<MainpageController>();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize.width(context);

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 4,
            ),

            // 여기서부터 메인 컨텐츠 화면
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 3, right: 3, top: 2, bottom: 2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // borderRadius: const BorderRadius.all(Radius.circular(10)),

                    // border: Border.all(
                    //   color: Colors.grey,
                    //   width: 0.5,
                    // )
                  ),
                  // 대학교 목록 선택 화면
                  child: const Row(
                    children: [
                      Text("optionaround"),
                      Spacer(),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                // 하단 컨텐츠
                // 1. 학교 셔틀 정보
                Container(
                  padding: const EdgeInsets.only(
                      left: 3, right: 3, top: 2, bottom: 2),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text("주변 버스/지하철 정보 >"),
                          Spacer(),
                        ],
                      ),
                      OptionBus(),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                Divider(
                  color: Colors.grey[300],
                  height: 1,
                  thickness: 1,
                ),
                // 2. 학교 특화 정보
                // ex: 성균관대: 인사캠 건물지도, 자과캠 건물지도, 공간명 코드 검색
                Container(
                  padding: const EdgeInsets.only(
                      left: 3, right: 3, top: 2, bottom: 2),
                  child: const Column(
                    children: [
                      Row(
                        children: [
                          Text("[성균관대학교 인사캠] 빠를지도"),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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
