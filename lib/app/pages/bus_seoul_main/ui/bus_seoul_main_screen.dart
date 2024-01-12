import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/bus_seoul_main/controller/bus_seoul_main_controller.dart';
import 'package:skkumap/app/utils/ad_widget.dart';
import 'package:skkumap/app_theme.dart';

import 'package:skkumap/app/components/NavigationBar/custom_navigation.dart';
import 'package:skkumap/app/components/bus/buslist_component.dart';
import 'package:skkumap/app/components/bus/refresh_button.dart';
// import 'package:skkumap/app/utils/screensize.dart';
import 'package:skkumap/app/types/bus_type.dart';
import 'package:skkumap/app/components/bus/topinfo.dart';

import 'package:skkumap/app/types/bus_status.dart';
import 'package:skkumap/app/types/time_format.dart';
import 'package:skkumap/app/components/bus/businfo_component.dart';

class BusDataScreen extends GetView<BusDataController> {
  const BusDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final double screenHeight = ScreenSize.height(context);
    // final double screenWidth = ScreenSize.width(context);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        // 화면 하단 광고
        child: Obx(
          () => controller.isBannerAdLoaded.value
              ? SizedBox(
                  height: 55,
                  child: AdWidgetContainer(
                    bannerAd: controller.bannerAd,
                  ),
                )
              : Container(
                  height: 55,
                ),
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
          // 상단 커스텀 내비게이션 바
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
          // 상단 정보 부분
          Container(
            height: 0.5,
            color: Colors.grey[300],
          ),
          Obx(() {
            return TopInfo(
              isLoaded: false,
              timeFormat: TimeFormat.format12Hour,
              busCount: controller.activeBusCount.value,
              busStatus: controller.activeBusCount.value > 0
                  ? BusStatus.active
                  : BusStatus.inactive,
            );
          }),
          Container(
            height: 0.5,
            color: Colors.grey[300],
          ),
          // 버스 정보 부분
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
                  // 번호판 && 버스 현재 위치 정보 부분
                  BusInfoComponent(
                    elapsedSeconds: 550,
                    currentStationIndex: 0,
                    lastStationIndex: 10,
                    plateNumber: '5678',
                    busType: BusType.hsscBus,
                  )
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
