import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/controller/ESKARA_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:skkumap/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

final Uri seoul_naver = Uri.parse(
    'nmap://route/walk?dlat=37.586462&dlng=126.995115&dname=%ec%9d%b8%ec%82%ac%ec%ba%a0%20%ec%85%94%ed%8b%80%20%ec%9c%84%ec%b9%98%20%7c%20%ec%8a%a4%ea%be%b8%eb%b2%84%ec%8a%a4');

final Uri seoul_kakao = Uri.parse(
    'kakaomap://route?ep=37.586462,126.995115&by=FOOT&eName=%ec%9d%b8%ec%82%ac%ec%ba%a0%20%ec%85%94%ed%8b%80%20%ec%9c%84%ec%b9%98%20%7c%20%ec%8a%a4%ea%be%b8%eb%b2%84%ec%8a%a4');

final Uri suwon_naver = Uri.parse(
    'nmap://route/walk?dlat=37.292602&dlng=126.972431&dname=%ec%9e%90%ea%b3%bc%ec%ba%a0%20%ec%85%94%ed%8b%80%20%ec%9c%84%ec%b9%98%20%7c%20%ec%8a%a4%ea%be%b8%eb%b2%84%ec%8a%a4');

final Uri suwon_kakao = Uri.parse(
    'kakaomap://route?ep=37.292602,126.972431&by=FOOT&eName=%ec%9e%90%ea%b3%bc%ec%ba%a0%20%ec%85%94%ed%8b%80%20%ec%9c%84%ec%b9%98%20%7c%20%ec%8a%a4%ea%be%b8%eb%b2%84%ec%8a%a4');

final seoul_marker =
    NMarker(id: 'seoul_marker', position: const NLatLng(37.586462, 126.995115));

final suwon_marker =
    NMarker(id: 'suwon_marker', position: const NLatLng(37.292602, 126.972431));

const seoul_cameraPosition = NCameraPosition(
  target: NLatLng(37.586462, 126.995115),
  zoom: 15,
  bearing: 45,
  tilt: 30,
);

const suwon_cameraPosition = NCameraPosition(
  target: NLatLng(37.292602, 126.972431),
  zoom: 15,
  bearing: 45,
  tilt: 30,
);

final seoul_onMarkerInfoWindow = NInfoWindow.onMarker(
  id: seoul_marker.info.id,
  text: "비천당 앞",
);

final controller = Get.find<ESKARAController>();

class ESKARA extends StatelessWidget {
  const ESKARA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.topCenter,
              color: AppColors.green_main,
              // color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const Text(
                          'ESKARA 인자셔틀',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'NotoSansBold',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.green_main,
                          size: 22,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Scrollbar(
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 3, 15, 0),
                      // color: Colors.green,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                            child: Divider(
                              color: Colors.grey[300],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 5,
                              ),
                              const Text(
                                '안내사항',
                                style: TextStyle(
                                  color: AppColors.green_main,
                                  fontFamily: 'NotoSansBold',
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '셔틀은 재학생/교직원만 이용 가능합니다\n9/13-14 양일간 기숙사 통금이 02:00로 연장됩니다\n축제 당일 상황에 따라 변동될 수 있습니다',
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      fontFamily: 'NotoSansRegular',
                                      fontSize: 13),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 3, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                            child: Divider(
                              color: Colors.grey[300],
                            ),
                          ),
                          const Row(
                            children: [
                              // Icon(
                              //   Icons.location_on,
                              //   color: AppColors.green_main,
                              // ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '인자셔틀 위치 [인사캠 → 자과캠]',
                                style: TextStyle(
                                  color: AppColors.green_main,
                                  fontFamily: 'NotoSansBold',
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              '9/13-14 문서수발(10:00)을 제외한 모든 셔틀 탑승위치 변경',
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'NotoSansBold',
                                  fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              '600주년 기념관 건너편 → 비천당 앞',
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'NotoSansBold',
                                  fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            width: double.infinity,
                            height: 180,
                            padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                            child: NaverMap(
                              options: const NaverMapViewOptions(
                                  initialCameraPosition: seoul_cameraPosition),
                              onMapReady: (controller) {
                                controller.addOverlay(seoul_marker);
                                // seoul_marker
                                //     .openInfoWindow(seoul_onMarkerInfoWindow);
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 10, 0, 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () async {
                                    FirebaseAnalytics.instance.logEvent(
                                      name: 'seoul_map_naver',
                                    );
                                    if (!await launchUrl(seoul_naver)) {
                                      // throw Exception('Could not launch seoul_nav');
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 173.w,
                                    height: 37.h,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF2DB400),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      '네이버 지도로 길찾기',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'NotoSansBold',
                                          fontSize: 13),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () async {
                                    FirebaseAnalytics.instance.logEvent(
                                      name: 'seoul_map_kakao',
                                    );
                                    if (!await launchUrl(seoul_kakao)) {
                                      // throw Exception('Could not launch seoul_nav');
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 173.w,
                                    height: 37.h,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFffe812),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      '카카오맵으로 길찾기',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'NotoSansBold',
                                          fontSize: 13),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 3, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                            child: Divider(
                              color: Colors.grey[300],
                            ),
                          ),
                          const Row(
                            children: [
                              // Icon(
                              //   Icons.location_on,
                              //   color: AppColors.green_main,
                              // ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '인자셔틀 시간표 [인사캠 → 자과캠]',
                                style: TextStyle(
                                  color: AppColors.green_main,
                                  fontFamily: 'NotoSansBold',
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              '기존 운행 셔틀 포함, *은 증차된 셔틀',
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'NotoSansRegular',
                                  fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                            child: Obx(
                              () {
                                return DataTable(
                                  columnSpacing: 90.w,
                                  columns: const [
                                    DataColumn(
                                      label: Text('9/13'),
                                    ),
                                    DataColumn(
                                      label: Text('비고'),
                                    ),
                                  ],
                                  rows: controller.seoul_13_busTimes
                                      .map((busTime) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Builder(
                                            builder: (BuildContext context) {
                                              String displayText;
                                              switch (busTime) {
                                                case '14:00':
                                                case '14:30':
                                                case '15:30':
                                                  displayText = '$busTime*';
                                                  break;
                                                default:
                                                  displayText = busTime;
                                              }
                                              return Text(
                                                displayText,
                                                style: TextStyle(
                                                  fontWeight: busTime ==
                                                          controller
                                                              .seoul_13_nextBusTime
                                                              .value
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  color: busTime ==
                                                          controller
                                                              .seoul_13_nextBusTime
                                                              .value
                                                      ? Colors.green
                                                      : Colors.black,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            busTime == '10:00'
                                                ? busTime ==
                                                        controller
                                                            .seoul_13_nextBusTime
                                                            .value
                                                    ? '기존 위치 탑승\n탑승 가능한 가장 빠른 셔틀'
                                                    : '기존 위치 탑승'
                                                : busTime ==
                                                        controller
                                                            .seoul_13_nextBusTime
                                                            .value
                                                    ? '탑승 가능한 가장 빠른 셔틀'
                                                    : ' ',
                                            style: TextStyle(
                                                color: busTime == '10:00'
                                                    ? busTime ==
                                                            controller
                                                                .seoul_13_nextBusTime
                                                                .value
                                                        ? Colors.green
                                                        : Colors.black
                                                    : busTime ==
                                                            controller
                                                                .seoul_13_nextBusTime
                                                                .value
                                                        ? Colors.green
                                                        : Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                            child: Obx(
                              () {
                                return DataTable(
                                  columnSpacing: 90.w,
                                  columns: const [
                                    DataColumn(
                                      label: Text('9/14'),
                                    ),
                                    DataColumn(
                                      label: Text('비고'),
                                    ),
                                  ],
                                  rows: controller.seoul_14_busTimes
                                      .map((busTime) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Builder(
                                            builder: (BuildContext context) {
                                              String displayText;
                                              switch (busTime) {
                                                case '10:15':
                                                case '10:30':
                                                case '10:45':
                                                case '11:00':
                                                case '11:15':
                                                case '11:30':
                                                case '11:45':
                                                case '12:15':
                                                case '12:30':
                                                case '12:45':
                                                case '13:00':
                                                case '13:15':
                                                case '13:30':
                                                  displayText = '$busTime*';
                                                  break;
                                                default:
                                                  displayText = busTime;
                                              }
                                              return Text(
                                                displayText,
                                                style: TextStyle(
                                                  fontWeight: busTime ==
                                                          controller
                                                              .seoul_14_nextBusTime
                                                              .value
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  color: busTime ==
                                                          controller
                                                              .seoul_14_nextBusTime
                                                              .value
                                                      ? Colors.green
                                                      : Colors.black,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            busTime == '10:00'
                                                ? busTime ==
                                                        controller
                                                            .seoul_14_nextBusTime
                                                            .value
                                                    ? '기존 위치 탑승\n탑승 가능한 가장 빠른 셔틀'
                                                    : '기존 위치 탑승'
                                                : busTime ==
                                                        controller
                                                            .seoul_14_nextBusTime
                                                            .value
                                                    ? '탑승 가능한 가장 빠른 셔틀'
                                                    : ' ',
                                            style: TextStyle(
                                                color: busTime == '10:00'
                                                    ? busTime ==
                                                            controller
                                                                .seoul_14_nextBusTime
                                                                .value
                                                        ? Colors.green
                                                        : Colors.black
                                                    : busTime ==
                                                            controller
                                                                .seoul_14_nextBusTime
                                                                .value
                                                        ? Colors.green
                                                        : Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 3, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                            child: Divider(
                              color: Colors.grey[300],
                            ),
                          ),
                          const Row(
                            children: [
                              // Icon(
                              //   Icons.location_on,
                              //   color: AppColors.green_main,
                              // ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '인자셔틀 위치 [자과캠 → 인사캠]',
                                style: TextStyle(
                                  color: AppColors.green_main,
                                  fontFamily: 'NotoSansBold',
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              '9/13-14 양일간 모든 셔틀 탑승위치 변경',
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'NotoSansBold',
                                  fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              'N센터 앞 → 의대 대강당 앞',
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'NotoSansBold',
                                  fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            width: double.infinity,
                            height: 180,
                            padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                            child: NaverMap(
                              options: const NaverMapViewOptions(
                                  initialCameraPosition: suwon_cameraPosition),
                              onMapReady: (controller) {
                                controller.addOverlay(suwon_marker);
                                // seoul_marker
                                //     .openInfoWindow(seoul_onMarkerInfoWindow);
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 10, 0, 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () async {
                                    FirebaseAnalytics.instance.logEvent(
                                      name: 'suwon_map_naver',
                                    );
                                    if (!await launchUrl(suwon_naver)) {
                                      // throw Exception('Could not launch seoul_nav');
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 173.w,
                                    height: 37.h,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF2DB400),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      '네이버 지도로 길찾기',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'NotoSansBold',
                                          fontSize: 13),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () async {
                                    FirebaseAnalytics.instance.logEvent(
                                      name: 'suwon_map_kakao',
                                    );
                                    if (!await launchUrl(suwon_kakao)) {
                                      // throw Exception('Could not launch seoul_nav');
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 173.w,
                                    height: 37.h,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFffe812),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      '카카오맵으로 길찾기',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'NotoSansBold',
                                          fontSize: 13),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 3, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                            child: Divider(
                              color: Colors.grey[300],
                            ),
                          ),
                          const Row(
                            children: [
                              // Icon(
                              //   Icons.location_on,
                              //   color: AppColors.green_main,
                              // ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '인자셔틀 시간표 [자과캠 → 인사캠]',
                                style: TextStyle(
                                  color: AppColors.green_main,
                                  fontFamily: 'NotoSansBold',
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              '기존 운행 셔틀 포함, *은 증차된 셔틀',
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'NotoSansRegular',
                                  fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                            child: Obx(
                              () {
                                return DataTable(
                                  columnSpacing: 90.w,
                                  columns: const [
                                    DataColumn(
                                      label: Text('9/13'),
                                    ),
                                    DataColumn(
                                      label: Text('비고'),
                                    ),
                                  ],
                                  rows: controller.suwon_13_busTimes
                                      .map((busTime) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Builder(
                                            builder: (BuildContext context) {
                                              String displayText;
                                              switch (busTime) {
                                                case '23:20':
                                                case '23:30':
                                                case '23:40':
                                                  displayText = '$busTime*';
                                                  break;
                                                default:
                                                  displayText = busTime;
                                              }
                                              return Text(
                                                displayText,
                                                style: TextStyle(
                                                  fontWeight: busTime ==
                                                          controller
                                                              .suwon_13_nextBusTime
                                                              .value
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  color: busTime ==
                                                          controller
                                                              .suwon_13_nextBusTime
                                                              .value
                                                      ? Colors.green
                                                      : Colors.black,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            busTime ==
                                                    controller
                                                        .suwon_13_nextBusTime
                                                        .value
                                                ? '탑승 가능한 가장 빠른 셔틀'
                                                : ' ',
                                            style: TextStyle(
                                                color: busTime ==
                                                        controller
                                                            .suwon_13_nextBusTime
                                                            .value
                                                    ? Colors.green
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                            child: Obx(
                              () {
                                return DataTable(
                                  columnSpacing: 90.w,
                                  columns: const [
                                    DataColumn(
                                      label: Text('9/14'),
                                    ),
                                    DataColumn(
                                      label: Text('비고'),
                                    ),
                                  ],
                                  rows: controller.suwon_14_busTimes
                                      .map((busTime) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Builder(
                                            builder: (BuildContext context) {
                                              String displayText;
                                              switch (busTime) {
                                                case '23:20':
                                                case '23:30':
                                                case '23:40':
                                                  displayText = '$busTime*';
                                                  break;
                                                default:
                                                  displayText = busTime;
                                              }
                                              return Text(
                                                displayText,
                                                style: TextStyle(
                                                  fontWeight: busTime ==
                                                          controller
                                                              .suwon_14_nextBusTime
                                                              .value
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  color: busTime ==
                                                          controller
                                                              .suwon_14_nextBusTime
                                                              .value
                                                      ? Colors.green
                                                      : Colors.black,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            busTime ==
                                                    controller
                                                        .suwon_14_nextBusTime
                                                        .value
                                                ? '탑승 가능한 가장 빠른 셔틀'
                                                : ' ',
                                            style: TextStyle(
                                                color: busTime ==
                                                        controller
                                                            .suwon_14_nextBusTime
                                                            .value
                                                    ? Colors.green
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
