import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skkumap/app/components/Bus/pulse_animation.dart';
import 'package:skkumap/app/pages/bus_seoul_main/controller/bus_seoul_main_controller.dart';
import 'package:skkumap/app/utils/ad_widget.dart';
import 'package:skkumap/app_theme.dart';

import 'package:skkumap/app/components/NavigationBar/custom_navigation.dart';
import 'package:skkumap/app/components/Bus/buslist_component.dart';
import 'package:skkumap/app/components/Bus/refresh_button.dart';
import 'package:skkumap/app/utils/screensize.dart';
import 'package:skkumap/app/components/Bus/bustype.dart';
import 'package:skkumap/app/components/Bus/licenseplate.dart';

class BusDataScreen extends GetView<BusDataController> {
  const BusDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenSize.height(context);
    final double screenWidth = ScreenSize.width(context);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        child: Obx(
          () => AdWidgetContainer(
              bannerAd: controller.bannerAd,
              isAdLoaded: controller.isAdLoaded.value,
              waitAdFail: controller.waitAdFail.value),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: AppColors.green_main,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          CustomNavigationBar(
            title: '인사캠 셔틀버스'.tr,
            backgroundColor: AppColors.green_main,
            isDisplayLeftBtn: true,
            isDisplayRightBtn: true,
            leftBtnAction: () {
              Get.back();
            },
            rightBtnAction: () {
              Get.toNamed('/busDetail');
            },
            rightBtnType: CustomNavigationBtnType.info,
          ),

          // const LicensePlate(
          //   plateNumber: '74거 5678',
          // ),

          Container(
            height: 0.5,
            color: Colors.grey[300],
          ),
          Container(
            height: 0.5,
            color: Colors.grey[300],
          ),
          Container(
            height: 30,
            color: Colors.grey[100],
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 4.0),
                      child: Obx(
                        () {
                          if (controller.currentTime.value.isEmpty ||
                              controller.activeBusCount.value == null) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[100]!,
                              highlightColor: Colors.white,
                              child: Container(
                                width: 200,
                                height: 20,
                                color: Colors.grey,
                              ),
                            );
                          } else {
                            return Row(
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                  child: Text(
                                    '${controller.currentTime.value}\u{00A0}${'기준'.tr}\u{00A0}·\u{00A0}${controller.activeBusCount.value}${'대 운행 중'.tr}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[800],
                                      fontFamily: 'CJKRegular',
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.grey[300],
          ),

          const Expanded(
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      BusListComponent(
                        stationName: "정차소(인문.농구장)",
                        stationNumber: null,
                        eta: "도착 정보 없음",
                        isFirstStation: true,
                        isLastStation: false,
                        isRotationStation: false,
                        color: AppColors.green_main,
                      ),
                      BusListComponent(
                        stationName: "학생회관(인문)",
                        stationNumber: null,
                        eta: "도착 정보 없음",
                        isFirstStation: false,
                        isLastStation: false,
                        isRotationStation: false,
                        color: AppColors.green_main,
                      ),
                      BusListComponent(
                        stationName: "정문(인문-하교)",
                        stationNumber: null,
                        eta: "도착 정보 없음",
                        isFirstStation: false,
                        isLastStation: false,
                        isRotationStation: false,
                        color: AppColors.green_main,
                      ),
                      BusListComponent(
                        stationName: "혜화로터리(하차지점)",
                        stationNumber: null,
                        eta: "도착 정보 없음",
                        isFirstStation: false,
                        isLastStation: false,
                        isRotationStation: false,
                        color: AppColors.green_main,
                      ),
                      BusListComponent(
                        stationName: "혜화역U턴지점",
                        stationNumber: null,
                        eta: "도착 정보 없음",
                        isFirstStation: false,
                        isLastStation: false,
                        isRotationStation: false,
                        color: AppColors.green_main,
                      ),
                      BusListComponent(
                        stationName: "혜화역(승차장)",
                        stationNumber: null,
                        eta: "도착 정보 없음",
                        isFirstStation: false,
                        isLastStation: false,
                        isRotationStation: false,
                        color: AppColors.green_main,
                      ),
                      BusListComponent(
                        stationName: "혜화로터리(경유)",
                        stationNumber: null,
                        eta: "도착 정보 없음",
                        isFirstStation: false,
                        isLastStation: false,
                        isRotationStation: false,
                        color: AppColors.green_main,
                      ),
                      BusListComponent(
                        stationName: "맥도날드 건너편",
                        stationNumber: null,
                        eta: "도착 정보 없음",
                        isFirstStation: false,
                        isLastStation: false,
                        isRotationStation: false,
                        color: AppColors.green_main,
                      ),
                      BusListComponent(
                        stationName: "정문(인문-등교)",
                        stationNumber: null,
                        eta: "도착 정보 없음",
                        isFirstStation: false,
                        isLastStation: false,
                        isRotationStation: false,
                        color: AppColors.green_main,
                      ),
                      BusListComponent(
                        stationName: "600주년 기념관",
                        stationNumber: null,
                        eta: "도착 정보 없음",
                        isFirstStation: false,
                        isLastStation: true,
                        isRotationStation: false,
                        color: AppColors.green_main,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 26,
                    left: 5,
                    child: Row(
                      children: [
                        LicensePlate(
                          plateNumber: '74거 5678',
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        PulseAnimation(
                          busType: BusType.hsscBus,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: const RefreshButton(
        busType: BusType.hsscBus,
      ),
    );
  }
}
