import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/bus_main/controller/bus_seoul_main_controller.dart';
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
              isLoaded: true,
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
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Stack(
                children: [
                  Obx(
                    () {
                      if (controller.loadingdone.value == false) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.green_main,
                          ),
                        );
                      }
                      return Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.busStations.length,
                            itemBuilder: (context, index) {
                              final station = controller.busStations[index];
                              return BusListComponent(
                                stationName: station.stationName,
                                stationNumber: station.stationNumber,
                                eta: station.eta,
                                isFirstStation: station.isFirstStation,
                                isLastStation: station.isLastStation,
                                isRotationStation: station.isRotationStation,
                                busType: BusType
                                    .hsscBus, // Ensure this matches your type
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  // 번호판 && 버스 현재 위치 정보 부분
                  const BusInfoComponent(
                    elapsedSeconds: 0,
                    currentStationIndex: 4,
                    lastStationIndex: 9,
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
