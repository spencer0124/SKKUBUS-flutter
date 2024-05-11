import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/components/mainpage/middle_snappingsheet/stationrow.dart';
import 'package:skkumap/app/pages/bus_inja_main/controller/bus_inja_main_controller.dart';
import 'package:skkumap/app_theme.dart';

import 'package:skkumap/app/components/NavigationBar/custom_navigation.dart';
import 'package:skkumap/app/utils/screensize.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

final List<String> dateitems = [
  '월요일',
  '화요일',
  '수요일',
  '목요일',
  '금요일',
  '토요일',
  '일요일'
];

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
    final double screenHeight = ScreenSize.height(context);
    final double screenWidth = ScreenSize.width(context);
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
                        Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${'인자셔틀'.tr} ${'[인사캠 → 자과캠]'.tr}',
                              style: const TextStyle(
                                color: AppColors.green_main,
                                fontFamily: 'CJKBold',
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const Spacer(),
                            Obx(() => SizedBox(
                                  width: 100,
                                  height: 50,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      value: controller.selectedDay.value,
                                      onChanged: (String? value) {
                                        controller.selectedDay.value = value;

                                        controller.selectedEnglishDay =
                                            controller
                                                .translateDayToEnglish(
                                                    controller.selectedDay
                                                            .value ??
                                                        '월요일')
                                                .obs;
                                        controller.fetchinjaBusSchedule(
                                            controller
                                                    .selectedEnglishDay.value ??
                                                'monday');
                                        controller.fetchjainBusSchedule(
                                            controller
                                                    .selectedEnglishDay.value ??
                                                'monday');
                                      },
                                      hint: Text(
                                        '요일 선택',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: dateitems
                                          .map((String item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                )),
                          ],
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
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // Row(
                        //   children: [
                        //     Container(
                        //       padding: const EdgeInsets.all(10.0),
                        //       height: 90,
                        //       width: dwidth / 2 - 5 - 20,
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
                        //                 '다음 셔틀',
                        //                 style: TextStyle(
                        //                   fontSize: 13,
                        //                   color: Colors.black,
                        //                   fontFamily: 'CJKBold',
                        //                 ),
                        //                 textAlign: TextAlign.start,
                        //               ),
                        //             ],
                        //           ),
                        //           SizedBox(
                        //             height: 5.h,
                        //           ),
                        //           const Text(
                        //             '12:00 셔틀\n(1시간 15분 후)',
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
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //     Container(
                        //       padding: const EdgeInsets.all(10.0),
                        //       height: 90,
                        //       width: dwidth / 2 - 5 - 20,
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
                        //                 '예상 소요시간',
                        //                 style: TextStyle(
                        //                   fontSize: 13,
                        //                   color: Colors.black,
                        //                   fontFamily: 'CJKBold',
                        //                 ),
                        //                 textAlign: TextAlign.start,
                        //               ),
                        //             ],
                        //           ),
                        //           SizedBox(
                        //             height: 5.h,
                        //           ),
                        //           const Text(
                        //             '1시간 45분\n(실시간 교통정보 반영)',
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
                                columnSpacing: 35,
                                columns: [
                                  DataColumn(
                                    label: Text('운영시간'.tr),
                                  ),
                                  const DataColumn(
                                    label: Text('운영대수'),
                                  ),
                                  const DataColumn(
                                    label: Text('특이사항'),
                                  ),
                                ],
                                rows:
                                    controller.injaBusSchedule.map((schedule) {
                                  return DataRow(cells: [
                                    DataCell(Row(
                                      children: [
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          schedule.operatingHours,
                                          style: TextStyle(
                                              fontWeight: (schedule
                                                          .isFastestBus &&
                                                      controller.selectedDay ==
                                                          controller.today)
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: (schedule.isFastestBus &&
                                                      controller.selectedDay ==
                                                          controller.today)
                                                  ? AppColors.green_main
                                                  : Colors.black),
                                        ),
                                      ],
                                    )),
                                    DataCell(Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          schedule.busCount.toString(),
                                          style: TextStyle(
                                              fontWeight: (schedule
                                                          .isFastestBus &&
                                                      controller.selectedDay ==
                                                          controller.today)
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                              color: (schedule.isFastestBus &&
                                                      controller.selectedDay ==
                                                          controller.today)
                                                  ? AppColors.green_main
                                                  : Colors.black),
                                        ),
                                      ],
                                    )),
                                    DataCell(
                                      Text(
                                        schedule.specialNotes
                                                ?.replaceAll(r'\n', '\n') ??
                                            ' ',
                                        style: TextStyle(
                                            fontWeight: (schedule
                                                        .isFastestBus &&
                                                    controller.selectedDay ==
                                                        controller.today)
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: (schedule.isFastestBus &&
                                                    controller.selectedDay ==
                                                        controller.today)
                                                ? AppColors.green_main
                                                : Colors.black),
                                      ),
                                    ),
                                  ]);
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                              '${'자인셔틀'.tr} ${'[자과캠 → 인사캠]'.tr}',
                              style: const TextStyle(
                                color: AppColors.green_main,
                                fontFamily: 'CJKBold',
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 3, 20, 0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                      child: Obx(
                        () {
                          return DataTable(
                            columnSpacing: 35,
                            columns: [
                              DataColumn(
                                label: Text('운영시간'.tr),
                              ),
                              const DataColumn(
                                label: Text('운영대수'),
                              ),
                              const DataColumn(
                                label: Text('특이사항'),
                              ),
                            ],
                            rows: controller.jainBusSchedule.map((schedule) {
                              return DataRow(cells: [
                                DataCell(Row(
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      schedule.operatingHours,
                                      style: TextStyle(
                                          fontWeight: (schedule.isFastestBus &&
                                                  controller.selectedDay ==
                                                      controller.today)
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: (schedule.isFastestBus &&
                                                  controller.selectedDay ==
                                                      controller.today)
                                              ? AppColors.green_main
                                              : Colors.black),
                                    ),
                                  ],
                                )),
                                DataCell(Row(
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      schedule.busCount.toString(),
                                      style: TextStyle(
                                          fontWeight: (schedule.isFastestBus &&
                                                  controller.selectedDay ==
                                                      controller.today)
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: (schedule.isFastestBus &&
                                                  controller.selectedDay ==
                                                      controller.today)
                                              ? AppColors.green_main
                                              : Colors.black),
                                    ),
                                  ],
                                )),
                                DataCell(SizedBox(
                                  child: Text(
                                    schedule.specialNotes
                                            ?.replaceAll(r'\n', '\n') ??
                                        ' ',
                                    style: TextStyle(
                                        fontWeight: (schedule.isFastestBus &&
                                                controller.selectedDay ==
                                                    controller.today)
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: (schedule.isFastestBus &&
                                                controller.selectedDay ==
                                                    controller.today)
                                            ? AppColors.green_main
                                            : Colors.black),
                                  ),
                                )),
                              ]);
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
