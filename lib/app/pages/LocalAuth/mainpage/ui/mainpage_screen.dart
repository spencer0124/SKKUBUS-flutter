
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/LocalAuth/mainpage/controller/mainpage_controller.dart';
import 'package:skkumap/app/pages/LocalAuth/mainpage/ui/scrollRow.dart';
import 'package:skkumap/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skkumap/app/pages/LocalAuth/mainpage/ui/customRow1.dart';
import 'package:skkumap/app/pages/LocalAuth/mainpage/ui/customRow2.dart';


import 'dart:ui' as ui;

final controller = Get.find<MainpageController>();

const seoulCameraPosition = NCameraPosition(
  target: NLatLng(hewa1Lat, hewa1Lon),
  zoom: 14,
  bearing: 45,
  tilt: 30,
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchIconImage(context);
    });
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
        //                       fontFamily: 'NotoSansbold',
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
        body: Column(
          children: [
            Builder(
              builder: (context) => Container(
                width: dwidth,
                height: 47.h,
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
            ),
            Container(
              // padding: const EdgeInsets.all(20),
              width: dwidth,
              height: 350.h,
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
                              Obx(
                                () {
                                  return loadingdone.value
                                      ? SizedBox(
                                          height: 350.h,
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
                                              initialCameraPosition:
                                                  seoulCameraPosition,
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
                                                // testRoute
                                              });

                                              // seoulMarker
                                              //     .openInfoWindow(markerinfo);
                                            },
                                          ),
                                        )
                                      : const Text('loading');
                                },
                              ),
                              Positioned(
                                left: 0.w,
                                right: 0.w,
                                top: 10.h,
                                child: const Center(child: ScrollableRow()),
                              ),
                              Positioned(
                                bottom: -10.h,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: dwidth,
                                  height: 22.h,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                    ),
                                  ),
                                  child: Divider(
                                    color: Colors.grey[500],
                                    thickness: 2.0,
                                    endIndent: dwidth * (1 / 2.2),
                                    indent: dwidth * (1 / 2.2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Obx(
              () => CustomRow2(
                iconData: Icons.stop_circle_rounded,
                titleText: '혜화역 1번 출구',
                subtitleText1: controller.jongro07BusRemainStation.value < 0
                    ? controller.jongro07BusMessage.value
                    : '${controller.jongro07BusRemainStation.value}번째 전 (${controller.jongro07BusRemainTimeMin.value}분 ${controller.jongro07BusRemainTimeSec.value}초)',
                subtitleText2: controller.hsscBusRemainStation.value == -1
                    ? '정보없음'
                    : '${controller.hsscBusRemainStation.value}번째 전 (${controller.hsscBusRemainStationName.value})',
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
              routeName: '/busData',
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ));
  }
}
