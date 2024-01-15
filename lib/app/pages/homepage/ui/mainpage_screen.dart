import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/KingoInfo/ui/kingoinfo_view.dart';
import 'package:skkumap/app/pages/homepage/controller/mainpage_controller.dart';
import 'package:skkumap/app/pages/homepage/data/map_data.dart';
import 'package:skkumap/app/components/mainpage/busrow.dart';
import 'package:skkumap/app/components/mainpage/stationrow.dart';
import 'package:skkumap/app/components/mainpage/scrollrow.dart';
import 'package:skkumap/app_theme.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import 'package:skkumap/app/components/mainpage/campusmarker.dart';

import 'package:skkumap/app/components/mainpage/bottomnavigation.dart';

import 'navermap.dart';

import '../controller/snappingsheet_controller.dart';

class Mainpage extends GetView<MainpageController> {
  const Mainpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double dwidth = MediaQuery.of(context).size.width;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SnappingSheet(
            controller: snappingSheetController,
            onSheetMoved: (sheetPosition) {
              // print("onSheetMoved - Current position ${sheetPosition.pixels}");
            },
            onSnapCompleted: (sheetPosition, _) {
              // Predefined snapping positions
              const List<double> predefinedPositions = [0.11, 0.5, 0.85];

              // Calculate the position factor
              double grabbingHeight =
                  22; // Adjust this value as per your grabbing height
              double screenHeight = MediaQuery.of(context).size.height;
              double totalMovableHeight = screenHeight - grabbingHeight;
              double positionFactor = sheetPosition.pixels / totalMovableHeight;

              // Find the closest predefined position
              double closest = predefinedPositions.reduce((a, b) =>
                  (positionFactor - a).abs() < (positionFactor - b).abs()
                      ? a
                      : b);

              // Print the closest position factor
              print("Closest predefined position to current: $closest");

              // Additional: print current position factor for reference
              print("Current position factor: $positionFactor");
            },
            lockOverflowDrag: true,
            snappingPositions: const [
              SnappingPosition.factor(
                positionFactor: 0.5,
                snappingCurve: Curves.easeOutExpo,
                snappingDuration: Duration(seconds: 1),
                grabbingContentOffset: GrabbingContentOffset.top,
              ),
              SnappingPosition.factor(
                positionFactor: 0.11,
                snappingCurve: Curves.easeOutExpo,
                snappingDuration: Duration(seconds: 1),
                grabbingContentOffset: GrabbingContentOffset.top,
              ),
              SnappingPosition.factor(
                positionFactor: 0.85,
                snappingCurve: Curves.easeOutExpo,
                snappingDuration: Duration(seconds: 1),
                grabbingContentOffset: GrabbingContentOffset.top,
              ),
            ],
            grabbingHeight: 22,
            grabbing: Container(
              height: 22,
              width: dwidth,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 2,
                      color: Colors.white,
                      offset: Offset(0, 10),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
            sheetBelow: SnappingSheetContent(
              draggable: true,
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      Obx(
                        () => CustomRow2(
                          isLoading: controller.jonroLoadingDone.value,
                          iconData: Icons.stop_circle_rounded,
                          titleText: '혜화역 1번 출구',
                          subtitleText1: controller
                                      .jonro07BusMessageVisible.value ==
                                  true
                              ? controller.jongro07BusMessage.value
                              : '${controller.jongro07BusRemainStation.value}번째 전 (${controller.jongro07BusRemainTotalTimeSec.value ~/ 60}분 ${controller.jongro07BusRemainTotalTimeSec.value % 60}초)',
                          subtitleText2: controller.hsscBusMessage.value,
                          containerColor: Colors.black,
                          containerText: '정류장',
                          routeName: '/busData',
                        ),
                      ),
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
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: dwidth,
                  // height: 350.h, // 이거 주석처리를 안하면 overflow 에러가 난다
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    height: dheight - 47.h,
                                    width: dwidth,
                                    child: _buildMap(),
                                  ),
                                  Positioned(
                                    left: 10,
                                    right: 10,
                                    top: statusBarHeight + 10,
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          alignment: Alignment.centerLeft,
                                          height: 49,
                                          width: dwidth * 0.8,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.list,
                                                size: 23,
                                                color: Colors.grey[600],
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                '장소, 강의실 번호, 버스, 정류장 검색',
                                                style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontFamily: 'CJKMedium',
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          alignment: Alignment.topCenter,
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: AppColors.green_main,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.green_main
                                                    .withOpacity(0.3),
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          width: 49,
                                          height: 49,
                                          child: const Column(
                                            children: [
                                              Spacer(),
                                              Icon(
                                                Icons.filter_alt,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                              Text(
                                                '필터',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'CJKMedium',
                                                  fontSize: 8,
                                                ),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    left: 0.w,
                                    right: 0.w,
                                    top: (statusBarHeight + 10 + 60),
                                    child: const Center(child: ScrollableRow()),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Bottomnavigation(),
          )
        ],
      ),
    );
  }

  NaverMap _buildMap() {
    return NaverMap(
      options: const NaverMapViewOptions(
        zoomGesturesEnable: true,
        locationButtonEnable: false,
        mapType: NMapType.basic,
        logoAlign: NLogoAlign.rightBottom,
        logoClickEnable: true,
        logoMargin: EdgeInsets.all(1000),
        activeLayerGroups: [NLayerGroup.building, NLayerGroup.transit],
        initialCameraPosition: seoulCameraPosition,
      ),
      onMapReady: (mapcontroller) {
        mapcontroller.addOverlayAll({
          ...buildCampusMarkers(),
          NMultipartPathOverlay(
            id: "jongroRoute",
            paths: [
              const NMultipartPath(
                color: Colors.green,
                outlineColor: Colors.white,
                coords: jongroRoute,
              ),
            ],
          ),
          jongrobusMarker1,
          jongrobusMarker2,
          jongrobusMarker3,
          jongrobusMarker4,
          jongrobusMarker5,
        });
      },
    );
  }
}
