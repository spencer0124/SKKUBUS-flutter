import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/mainpage/controller/mainpage_controller.dart';
import 'package:skkumap/app/utils/screensize.dart';
import 'package:skkumap/app/pages/mainpage/ui/snappingsheet/option_bus.dart';
import 'package:skkumap/app/pages/mainpage/ui/snappingsheet/option_campus_service_button.dart';

// '캠퍼스' 탭
// 현재 위치를 기준으로, (지원하는 목록에서) 가장 가까운 대학교 캠퍼스 정보를 불러옴

class OptionCampus extends StatelessWidget {
  OptionCampus({Key? key}) : super(key: key);

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
              height: 7,
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
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 3, right: 8, top: 0, bottom: 3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          // border: Border.all(
                          //   color: Colors.grey,
                          //   width: 0.5,
                          // ),
                        ),
                        child: Row(
                          children: [
                            const Text("성균관대학교 (인사캠)",
                                style: TextStyle(
                                  fontFamily: "ProductSansBold",
                                  fontSize: 15,
                                )),
                            const SizedBox(width: 5),
                            SvgPicture.asset(
                                "assets/tossface/toss_arrow_down.svg",
                                width: 20,
                                height: 20),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                // 가능한 서비스 목록
                Container(
                  padding: const EdgeInsets.only(
                      left: 3, right: 3, top: 2, bottom: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 15),
                      CustomServiceBtn(
                        title: "스꾸패스",
                        iconPath: "assets/tossface/toss_ticket_yellow.svg",
                        onTap: () {},
                      ),
                      const Spacer(),
                      CustomServiceBtn(
                        title: "건물지도",
                        iconPath: "assets/tossface/toss_building.svg",
                        onTap: () {
                          Get.toNamed('/hsscbuildingmap');
                        },
                      ),
                      const Spacer(),
                      CustomServiceBtn(
                        title: "건물코드",
                        iconPath: "assets/tossface/toss_numbers.svg",
                        onTap: () {
                          Get.toNamed('/searchlist');
                        },
                      ),
                      const Spacer(),
                      CustomServiceBtn(
                        title: "분실물",
                        iconPath: "assets/tossface/toss_luggage.svg",
                        onTap: () {
                          Get.toNamed('/lostandfound');
                        },
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
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
                          SizedBox(width: 15),
                          Text("셔틀버스 / 대중교통",
                              style: TextStyle(
                                fontFamily: "ProductSansBold",
                                fontSize: 15,
                              )),
                          Spacer(),
                        ],
                      ),
                      OptionBus(),
                      OptionBus(),
                      OptionBus(),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                // 2. 학교 특화 정보
                // ex: 성균관대: 인사캠 건물지도, 자과캠 건물지도, 공간명 코드 검색
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
