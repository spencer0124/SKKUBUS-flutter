import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/bus_inja_main/controller/bus_inja_main_controller.dart';
import 'package:skkumap/app_theme.dart';

import 'package:skkumap/app/components/CustomNavigationBar.dart';

// 인사캠 셔틀 탑승 장소 위도, 경도, 목적지 이름
const double seoulLat = 37.587308;
const double seoulLon = 126.993688;
const String seoulDestnameEncode =
    '%EC%8A%A4%EA%BE%B8%EB%B2%84%EC%8A%A4%20%7C%20%EC%9D%B8%EC%82%AC%EC%BA%A0%20%EC%85%94%ED%8B%80%20%EC%9C%84%EC%B9%98';

// 자과캠 셔틀 탑승 장소 위도, 경도, 목적지 이름
const double suwonLat = 37.292345;
const double suwonLon = 126.975532;
const String suwonDestnameEncode =
    '%EC%8A%A4%EA%BE%B8%EB%B2%84%EC%8A%A4%20%7C%20%EC%9E%90%EA%B3%BC%EC%BA%A0%20%EC%85%94%ED%8B%80%20%EC%9C%84%EC%B9%98';

// 인사캠 길찾기 바로가기 링크
final Uri seoulMapNaver = Uri.parse(
    'nmap://route/walk?dlat=$seoulLat&dlng=$seoulLon&dname=$seoulDestnameEncode');
final Uri seoulMapKakao = Uri.parse(
    'kakaomap://route?ep=$seoulLat,$seoulLon&by=FOOT&eName=$seoulDestnameEncode');
final Uri seoulMapApple = Uri.parse('maps://?t=m&daddr=$seoulLat,$seoulLon');

// 자과캠 길찾기 바로가기 링크
final Uri suwonMapNaver = Uri.parse(
    'nmap://route/walk?dlat=$suwonLat&dlng=$suwonLon&dname=$suwonDestnameEncode');
final Uri suwonMapKakao = Uri.parse(
    'kakaomap://route?ep=$suwonLat,$suwonLon&by=FOOT&eName=$suwonDestnameEncode');
final Uri suwonMapApple = Uri.parse('maps://?t=m&daddr=$suwonLat,$suwonLon');

// 인사캠 셔틀 탑승 위치 네이버 지도 관련 설정들
final seoulMarker =
    NMarker(id: 'seoul_marker', position: const NLatLng(seoulLat, seoulLon));
const seoulCameraPosition = NCameraPosition(
  target: NLatLng(seoulLat, seoulLon),
  zoom: 15,
  bearing: 45,
  tilt: 30,
);

// 자과캠 셔틀 탑승 위치 네이버 지도 관련
final suwonMarker =
    NMarker(id: 'suwon_marker', position: const NLatLng(suwonLat, suwonLon));
const suwonCameraPosition = NCameraPosition(
  target: NLatLng(suwonLat, suwonLon),
  zoom: 15,
  bearing: 45,
  tilt: 30,
);

class ESKARA extends StatelessWidget {
  const ESKARA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InjaMainController>();
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
          CustomNavigationBar(
            title: '인자셔틀'.tr,
            backgroundColor: AppColors.green_main,
            isDisplayLeftBtn: true,
            isDisplayRightBtn: true,
            leftBtnAction: () {
              Get.back();
            },
            rightBtnAction: () {
              Get.toNamed('/injadetail');
            },
            rightBtnType: CustomNavigationBtnType.info,
          ),
          Container(
            height: 0.5,
            color: Colors.grey[300],
          ),
          Container(
            height: 0.5,
            color: Colors.grey[300],
          ),
          Container(
            height: 0.5,
            color: Colors.grey[300],
          ),
          Flexible(
            child: Scrollbar(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 3, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                        //   child: Divider(
                        //     color: Colors.grey[300],
                        //   ),
                        // ),
                        Text(
                          '${'인자셔틀'.tr} ${'[인사캠 → 자과캠]'.tr}',
                          style: const TextStyle(
                            color: AppColors.green_main,
                            fontFamily: 'CJKBold',
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        // Obx(
                        //   () => Text(
                        //     '예상 소요시간 : ${controller.duration.value}',
                        //     style: const TextStyle(
                        //       color: Colors.black,
                        //       fontFamily: 'CJKRegular',
                        //       fontSize: 12,
                        //     ),
                        //     textAlign: TextAlign.start,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Container(
                        //       padding: const EdgeInsets.all(10.0),
                        //       width: 170.w,
                        //       height: 90.h,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: Colors.grey[100],
                        //         border: Border.all(
                        //           color: Colors.grey[300]!,
                        //           width: 1,
                        //         ),
                        //       ),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           const Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text(
                        //                 '승차알림 설정하기',
                        //                 style: TextStyle(
                        //                   fontSize: 13,
                        //                   color: Colors.black,
                        //                   fontFamily: 'CJKBold',
                        //                 ),
                        //                 textAlign: TextAlign.start,
                        //               ),
                        //               Icon(
                        //                 Icons.alarm,
                        //                 size: 18,
                        //               ),
                        //             ],
                        //           ),
                        //           SizedBox(
                        //             height: 5.h,
                        //           ),
                        //           const Text(
                        //             '선택한 셔틀이 출발하기\n15분 전에 알려드릴게요',
                        //             style: TextStyle(
                        //               fontSize: 12,
                        //               color: Colors.black,
                        //               fontFamily: 'CJKRegular',
                        //             ),
                        //             textAlign: TextAlign.start,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     Container(
                        //       padding: const EdgeInsets.all(10.0),
                        //       width: 170.w,
                        //       height: 90.h,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: Colors.grey[100],
                        //         border: Border.all(
                        //           color: Colors.grey[300]!,
                        //           width: 1,
                        //         ),
                        //       ),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           const Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text(
                        //                 '하차알림 설정하기',
                        //                 style: TextStyle(
                        //                   fontSize: 13,
                        //                   color: Colors.black,
                        //                   fontFamily: 'CJKBold',
                        //                 ),
                        //                 textAlign: TextAlign.start,
                        //               ),
                        //               Icon(
                        //                 Icons.alarm,
                        //                 size: 18,
                        //               ),
                        //             ],
                        //           ),
                        //           SizedBox(
                        //             height: 5.h,
                        //           ),
                        //           const Text(
                        //             '선택한 셔틀이 도착하기\n10분 전에 알려드릴게요',
                        //             style: TextStyle(
                        //               fontSize: 12,
                        //               color: Colors.black,
                        //               fontFamily: 'CJKRegular',
                        //             ),
                        //             textAlign: TextAlign.start,
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),

                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                          child: Obx(
                            () {
                              return DataTable(
                                columnSpacing: 90.w,
                                columns: [
                                  DataColumn(
                                    label: Text('운행시간'.tr),
                                  ),
                                  DataColumn(
                                    label: Text('비고'.tr),
                                  ),
                                ],
                                rows:
                                    controller.schedule('seoul').map((busTime) {
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Builder(
                                          builder: (BuildContext context) {
                                            String displayText;
                                            displayText = busTime;
                                            return Text(
                                              displayText,
                                              style: TextStyle(
                                                fontWeight: busTime ==
                                                        controller
                                                            .seoulNextBusTime
                                                            .value
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                color: busTime ==
                                                        controller
                                                            .seoulNextBusTime
                                                            .value
                                                    ? AppColors.green_main
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
                                                      .seoulNextBusTime.value
                                              ? '탑승 가능한 가장 빠른 셔틀'.tr
                                              : ' ',
                                          style: TextStyle(
                                              color: busTime ==
                                                      controller
                                                          .seoulNextBusTime
                                                          .value
                                                  ? AppColors.green_main
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
                        Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${'인자셔틀'.tr} ${'[자과캠 → 인사캠]'.tr}',
                              style: const TextStyle(
                                color: AppColors.green_main,
                                fontFamily: 'CJKBold',
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                          child: Obx(
                            () {
                              return DataTable(
                                columnSpacing: 90.w,
                                columns: [
                                  DataColumn(
                                    label: Text('운행시간'.tr),
                                  ),
                                  DataColumn(
                                    label: Text('비고'.tr),
                                  ),
                                ],
                                rows:
                                    controller.schedule('suwon').map((busTime) {
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Builder(
                                          builder: (BuildContext context) {
                                            String displayText;
                                            displayText = busTime;
                                            return Text(
                                              displayText,
                                              style: TextStyle(
                                                fontWeight: busTime ==
                                                        controller
                                                            .suwonNextBusTime
                                                            .value
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                color: busTime ==
                                                        controller
                                                            .suwonNextBusTime
                                                            .value
                                                    ? AppColors.green_main
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
                                                      .suwonNextBusTime.value
                                              ? '탑승 가능한 가장 빠른 셔틀'.tr
                                              : ' ',
                                          style: TextStyle(
                                              color: busTime ==
                                                      controller
                                                          .suwonNextBusTime
                                                          .value
                                                  ? AppColors.green_main
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
      ),
    );
  }
}
