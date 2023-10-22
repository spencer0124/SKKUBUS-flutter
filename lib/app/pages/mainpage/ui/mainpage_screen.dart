import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/mainpage/controller/mainpage_controller.dart';
import 'package:skkumap/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skkumap/app/pages/mainpage/ui/customRow1.dart';
import 'package:skkumap/app/pages/mainpage/ui/customRow2.dart';

import 'package:cupertino_icons/cupertino_icons.dart';

import 'package:lottie/lottie.dart';

final arrowPathOverlay = NPathOverlay(
  id: 'path_overlay',
  coords: [
    const NLatLng(37.587308, 126.993688),
    const NLatLng(hewa1Lat, hewa1Lon)
  ],
  color: Colors.blue, // Color of the line
  width: 2, // Width of the line
);

// final seoulMarker = NMarker(
//   id: 'seoul_marker',
//   position: const NLatLng(hewa1Lat, hewa1Lon),
//   // icon: controller.iconImage,
// );

const seoulCameraPosition = NCameraPosition(
  target: NLatLng(hewa1Lat, hewa1Lon),
  zoom: 14.5,
  bearing: 45,
  tilt: 30,
);

// 혜화역 1번 출구 위도, 경도, 목적지 이름
const double hewa1Lat = 37.583427;
const double hewa1Lon = 127.001850;
const String hewa1DestnameEncode =
    '%EC%8A%A4%EA%BE%B8%EB%B2%84%EC%8A%A4%20%7C%20%EC%9D%B8%EC%82%AC%EC%BA%A0%20%EC%85%94%ED%8B%80%20%EC%9C%84%EC%B9%98';

final controller = Get.find<mainpageController>();

final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

class mainpage extends StatelessWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Container(
            // width: 50,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  // <Widget>
                  [
                SizedBox(
                  height: 60.h,
                ),
                Container(
                  height: 100.h,
                  color: Colors.white,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text('H'),
                        ),
                        SizedBox(height: 10.0),
                        Text('조승용'),
                        Text('소프트웨어학과'),
                      ],
                    ),
                  ),
                ),
                // This is your list of items
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    '길찾기',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'CJKMedium',
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                ListTile(
                  title: const Text('네비게이션'),
                  onTap: () {
                    // Do something when this list item is tapped
                    Navigator.pop(context); // Close the drawer
                  },
                ),
                // Add more ListTiles for more items
              ],
            ),
          ),
        ),

        // bottomNavigationBar: BottomAppBar(
        //   color: Colors.grey[200],
        //   child: SizedBox(
        //     height: 30.h,
        //     child: const Text(' '),
        //   ),
        // ),
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
                                  Scaffold.of(context).openDrawer();
                                  print('click');
                                },
                                child: const Icon(
                                  CupertinoIcons.list_bullet,
                                  color: Colors.white,
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
                                  Get.toNamed('/userchat');
                                },
                                child: const Icon(
                                  CupertinoIcons.chat_bubble_2,
                                  color: Colors.white,
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
                                              locationButtonEnable: false,
                                              // mapType: NMapType.navi,
                                              logoAlign: NLogoAlign.rightBottom,
                                              logoClickEnable: true,
                                              logoMargin: EdgeInsets.all(1000),
                                              activeLayerGroups: [
                                                NLayerGroup.building,
                                                NLayerGroup.transit,
                                                NLayerGroup.traffic,
                                              ],
                                              initialCameraPosition:
                                                  seoulCameraPosition,
                                            ),
                                            onMapReady: (controller) {
                                              controller
                                                  .addOverlay(seoulMarker);
                                              controller
                                                  .addOverlay(arrowPathOverlay);
                                              // seoulMarker
                                              //     .openInfoWindow(markerinfo);
                                            },
                                          ),
                                        )
                                      : const Text('loading');
                                },
                              ),
                              Positioned(
                                left: 20.w,
                                right: 20.w,
                                top: 10.h,
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(30.w, 0, 30.w, 0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              12), // Add some horizontal padding
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                0.5), // Color of the shadow
                                            spreadRadius:
                                                1, // Extent of the shadow, negative values can decrease the size of the shadow
                                            blurRadius: 5, // Amount of blurring
                                            offset: const Offset(
                                                0, 3), // Position of the shadow
                                          ),
                                        ],
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize
                                            .min, // Ensure the Row takes the minimum space required by its children
                                        children: [
                                          Icon(CupertinoIcons.location_fill,
                                              color: Colors.black, size: 15),
                                          SizedBox(
                                              width:
                                                  8), // Add some space between the icon and text
                                          Row(
                                            children: [
                                              Text(
                                                '현재위치 ',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'CJKMedium',
                                                  fontSize: 14,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                              Icon(
                                                CupertinoIcons.right_chevron,
                                                size: 10,
                                              ),
                                              Text(
                                                ' 혜화역 정류장',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'CJKMedium',
                                                  fontSize: 14,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   bottom: 30.h,
                              //   left: 0,
                              //   right: 0,
                              //   child: Center(
                              //     child: Container(
                              //       width: dwidth * 0.9,
                              //       height: 30.h,
                              //       decoration: const BoxDecoration(
                              //         color: Colors.red,
                              //         borderRadius: BorderRadius.only(
                              //           topLeft: Radius.circular(25),
                              //           topRight: Radius.circular(25),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),

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
            CustomRow2(
              iconData: Icons.stop_circle_rounded,
              titleText: '혜화역 정류장',
              subtitleText1: '[인사캠 셔틀] 5개 전 전류장',
              subtitleText2: '[종로07] 3개 전 전류장',
              containerColor: Colors.red[400]!,
              containerText: '위치 기반',
              routeName: '/busData',
            ),
            const CustomRow1(
              iconData: Icons.directions_bus,
              titleText: '인사캠 셔틀',
              subtitleText: '정차소(인문.농구장) ↔ 600주년 기념관',
              containerColor: AppColors.green_main,
              containerText: '성대',
              routeName: '/busData',
            ),
            CustomRow1(
              iconData: Icons.directions_bus,
              titleText: '종로 07',
              subtitleText: '명륜새마을금고 ↔ 명륜새마을금고',
              containerColor: Colors.green[400]!,
              containerText: '마을',
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
            SizedBox(
              height: 5.h,
            ),
          ],
        ));
  }
}
