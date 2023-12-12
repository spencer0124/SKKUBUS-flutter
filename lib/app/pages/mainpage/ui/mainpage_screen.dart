import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/KingoInfo/ui/kingoinfo_view.dart';
import 'package:skkumap/app/pages/mainpage/controller/mainpage_controller.dart';
import 'package:skkumap/app/pages/mainpage/ui/customRow1.dart';
import 'package:skkumap/app/pages/mainpage/ui/customRow2.dart';
import 'package:skkumap/app/pages/mainpage/ui/scrollRow.dart';
import 'package:skkumap/app_theme.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

final controller = Get.find<MainpageController>();

const seoulCameraPosition = NCameraPosition(
  target: NLatLng(37.582716, 126.98389456),
  zoom: 13.4,
  bearing: 90,
  tilt: 0,
);

// 혜화역 1번 출구 위도, 경도, 목적지 이름
const double hewa1Lat = 37.583427;
const double hewa1Lon = 127.001850;

final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

class Mainpage extends StatelessWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   controller.fetchIconImage(context);
    // });
    // return FutureBuilder(
    //     future: controller.fetchIconImage(context),
    //     builder: (context, snapshot) {
    return Scaffold(
      // drawer: Drawer(
      //   child: Container(
      //     // width: 50,
      //     color: Colors.white,
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children:
      //           // <Widget>
      //           [
      //         SizedBox(
      //           height: 80.h,
      //         ),
      //         Container(
      //           height: 140.h,
      //           color: Colors.white,
      //           child: Center(
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 const SizedBox(
      //                   child: CircleAvatar(
      //                     radius: 45,
      //                     backgroundColor: Colors.white,
      //                     child: Icon(CupertinoIcons.person_alt_circle,
      //                         color: Colors.grey, size: 80),
      //                   ),
      //                 ),
      //                 SizedBox(height: 2.h),
      //                 Obx(
      //                   () => Text(
      //                     controller.name.value,
      //                     style: const TextStyle(
      //                       color: Colors.black,
      //                       fontFamily: 'CJKBold',
      //                       fontSize: 15,
      //                     ),
      //                   ),
      //                 ),
      //                 Obx(
      //                   () => Text(
      //                     controller.subname.value,
      //                     style: TextStyle(
      //                       color: Colors.grey[800],
      //                       fontFamily: 'CJKMedium',
      //                       fontSize: 13,
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         Divider(
      //           color: Colors.grey[100],
      //           thickness: 0.8,
      //           endIndent: 30.w,
      //           indent: 30.w,
      //         ),
      //         SizedBox(
      //           height: 15.h,
      //         ),
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(30.w, 0, 0, 0),
      //           child: GestureDetector(
      //             onTap: () {
      //               Get.toNamed('/kingologin');
      //             },
      //             child: const Text(
      //               '킹고 계정 연동하기',
      //               style: TextStyle(
      //                 color: Colors.black,
      //                 fontFamily: 'CJKMedium',
      //                 fontSize: 18,
      //               ),
      //               textAlign: TextAlign.start,
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 12.h,
      //         ),
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(30.w, 0, 0, 0),
      //           child: GestureDetector(
      //             onTap: () {
      //               launchUrl(
      //                 Uri.parse(
      //                     'https://brash-distance-4c3.notion.site/2ce3b22006f64d65ae92ea3f01ec4bc2?pvs=4'),
      //               );
      //             },
      //             child: const Text(
      //               '공지사항',
      //               style: TextStyle(
      //                 color: Colors.black,
      //                 fontFamily: 'CJKMedium',
      //                 fontSize: 18,
      //               ),
      //               textAlign: TextAlign.start,
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 12.h,
      //         ),
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(30.w, 0, 0, 0),
      //           child: GestureDetector(
      //             onTap: () {
      //               Get.toNamed('/kingologin');
      //             },
      //             child: const Text(
      //               '환경설정',
      //               style: TextStyle(
      //                 color: Colors.black,
      //                 fontFamily: 'CJKMedium',
      //                 fontSize: 18,
      //               ),
      //               textAlign: TextAlign.start,
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10.h,
      //         ),
      //         Divider(
      //           color: Colors.grey[100],
      //           thickness: 0.8,
      //           endIndent: 30.w,
      //           indent: 30.w,
      //         ),
      //         SizedBox(
      //           height: 10.h,
      //         ),
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(30.w, 0, 30.w, 0),
      //           child: GestureDetector(
      //             onTap: () {
      //               Get.toNamed('/kingologin');
      //             },
      //             child: const Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Text(
      //                   '홈화면 설정',
      //                   style: TextStyle(
      //                     color: Colors.black,
      //                     fontFamily: 'CJKMedium',
      //                     fontSize: 18,
      //                   ),
      //                   textAlign: TextAlign.start,
      //                 ),
      //                 Text(
      //                   '지도 화면',
      //                   style: TextStyle(
      //                     color: AppColors.green_main,
      //                     fontFamily: 'CJKMedium',
      //                     fontSize: 18,
      //                   ),
      //                   textAlign: TextAlign.start,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 12.h,
      //         ),
      //         Divider(
      //           color: Colors.grey[100],
      //           thickness: 0.8,
      //           endIndent: 30.w,
      //           indent: 30.w,
      //         ),
      //         SizedBox(
      //           height: 12.h,
      //         ),
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(30.w, 0, 0, 0),
      //           child: GestureDetector(
      //             onTap: () {
      //               launchUrl(Uri.parse('https://pf.kakao.com/_cjxexdG'));
      //             },
      //             child: Text(
      //               '고객센터',
      //               style: TextStyle(
      //                 color: Colors.grey[800],
      //                 fontFamily: 'CJKMedium',
      //                 fontSize: 14,
      //               ),
      //               textAlign: TextAlign.start,
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 12.h,
      //         ),
      //         Padding(
      //           padding: EdgeInsets.fromLTRB(30.w, 0, 0, 0),
      //           child: GestureDetector(
      //             onTap: () {
      //               launchUrl(
      //                 Uri.parse(
      //                     'https://brash-distance-4c3.notion.site/17f6a2ae496f4e6e95af6f8148e81f78?pvs=4'),
      //               );
      //             },
      //             child: Text(
      //               '정보수정제안',
      //               style: TextStyle(
      //                 color: Colors.grey[800],
      //                 fontFamily: 'CJKMedium',
      //                 fontSize: 14,
      //               ),
      //               textAlign: TextAlign.start,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.grey[200],
      //   child: SizedBox(
      //     height: 30.h,
      //     child: const Text('ad'),
      //   ),
      // ),
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const ui.Size.fromHeight(0.0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: AppColors.green_main,
          elevation: 0,
        ),
      ),
      body: SnappingSheet(
        controller: controller.snappingSheetController,
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
              (positionFactor - a).abs() < (positionFactor - b).abs() ? a : b);

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
              height: 48.h,
              color: AppColors.green_main,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                // Scaffold.of(context).openDrawer();
                                // controller.fetchSecureStorage();
                              },
                              child: const Icon(
                                CupertinoIcons.list_bullet,
                                color: AppColors.green_main,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 3.w,
                            ),
                            Semantics(
                              label: '스꾸버스 앱 로고',
                              child: Text(
                                'appname'.tr,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontFamily: 'ProductBold'.tr,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Get.toNamed('/userchat');
                              },
                              child: const Icon(
                                CupertinoIcons.chat_bubble_2,
                                // color: Colors.white,
                                color: AppColors.green_main,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
                                child: NaverMap(
                                  options: const NaverMapViewOptions(
                                    zoomGesturesEnable: true,
                                    locationButtonEnable: false,
                                    mapType: NMapType.navi,
                                    logoAlign: NLogoAlign.rightBottom,
                                    logoClickEnable: true,
                                    logoMargin: EdgeInsets.all(1000),
                                    activeLayerGroups: [
                                      NLayerGroup.building,
                                      NLayerGroup.transit,
                                      // NLayerGroup.traffic,
                                    ],
                                    initialCameraPosition: seoulCameraPosition,
                                  ),
                                  onMapReady: (controller) {
                                    controller.addOverlayAll({
                                      // station1,
                                      station2,
                                      station3,
                                      station4,
                                      station5,
                                      station6,
                                      station7,
                                      station8,
                                      station9,
                                      station10,
                                      station11,
                                      station12,
                                      station13,
                                      station14,
                                      station15,
                                      station16,
                                      station17,
                                      station18,
                                      station19,
                                      station20,
                                      jongroRoute,
                                      jongrobusMarker1,
                                      jongrobusMarker2,
                                      jongrobusMarker3,
                                      jongrobusMarker4,
                                      jongrobusMarker5,
                                      // testRoute
                                    });

                                    // seoulMarker
                                    //     .openInfoWindow(markerinfo);
                                  },
                                ),
                              ),
                              Positioned(
                                left: 0.w,
                                right: 0.w,
                                top: 10.h,
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
    );
  }
}
