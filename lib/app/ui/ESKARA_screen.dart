import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/controller/ESKARA_controller.dart';
import 'package:skkumap/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 좌표랑 목적지 이름 다 완성 아니니까 완성하고 한번씩 테스트해보기

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
                        Text(
                          '인자셔틀'.tr,
                          style: const TextStyle(
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
                              Text(
                                '안내사항'.tr,
                                style: const TextStyle(
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
                                  '요금 무료\n매주 금요일 출발 7시 버스는 8시 출발로 대체됩니다'.tr,
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
                          Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${'인자셔틀'.tr}\u{00A0}${'위치'.tr}\u{00A0}${'[인사캠 → 자과캠]'.tr}',
                                style: const TextStyle(
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
                              '${'탑승장소'.tr} : ${'600주년 기념관 건너편'.tr}',
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'NotoSansRegular',
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
                                  initialCameraPosition: seoulCameraPosition),
                              onMapReady: (controller) {
                                controller.addOverlay(seoulMarker);
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 10, 0, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () async {
                                    controller.executeMap(
                                        type: 'seoul',
                                        mapNameEn: 'naver_map',
                                        mapNameKr: '네이버 지도',
                                        mapUri: seoulMapNaver,
                                        playStoreLink:
                                            'https://play.google.com/store/apps/details?id=com.nhn.android.nmap&hl=ko&gl=US',
                                        appStoreLink:
                                            'https://apps.apple.com/kr/app/naver-map-navigation/id311867728?l=en-GB');
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
                                    child: Text(
                                      '네이버 지도로 길찾기'.tr,
                                      style: const TextStyle(
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
                                    controller.executeMap(
                                        type: 'seoul',
                                        mapNameEn: 'kakao_map',
                                        mapNameKr: '카카오맵',
                                        mapUri: seoulMapKakao,
                                        playStoreLink:
                                            'https://play.google.com/store/apps/details?id=net.daum.android.map&hl=ko&gl=US',
                                        appStoreLink:
                                            'https://apps.apple.com/kr/app/kakaomap-korea-no-1-map/id304608425?l=en-GB');
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
                                    child: Text(
                                      '카카오맵으로 길찾기'.tr,
                                      style: const TextStyle(
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
                          // 애플지도 추가1
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () async {
                                    controller.executeMap(
                                        type: 'seoul',
                                        mapNameEn: 'apple_map',
                                        mapNameKr: '애플 지도',
                                        mapUri: seoulMapApple,
                                        playStoreLink:
                                            'https://apps.apple.com/kr/app/maps/id915056765?l=en-GB',
                                        appStoreLink:
                                            'https://apps.apple.com/kr/app/maps/id915056765?l=en-GB');
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 173.w,
                                    height: 37.h,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      '애플 지도로 길찾기'.tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'NotoSansBold',
                                          fontSize: 13),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
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
                                '${'인자셔틀'.tr} ${'시간표'.tr} ${'[인사캠 → 자과캠]'.tr}',
                                style: const TextStyle(
                                  color: AppColors.green_main,
                                  fontFamily: 'NotoSansBold',
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
                                  rows: controller
                                      .schedule('seoul')
                                      .map((busTime) {
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
                                '${'인자셔틀'.tr}\u{00A0}${'위치'.tr}\u{00A0}${'[자과캠 → 인사캠]'.tr}',
                                style: const TextStyle(
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
                              '${'탑승장소'.tr} : ${'N센터 앞'.tr}',
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'NotoSansRegular',
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
                                  initialCameraPosition: suwonCameraPosition),
                              onMapReady: (controller) {
                                controller.addOverlay(suwonMarker);
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 10, 0, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () async {
                                    controller.executeMap(
                                        type: 'suwon',
                                        mapNameEn: 'naver_map',
                                        mapNameKr: '네이버 지도',
                                        mapUri: suwonMapNaver,
                                        playStoreLink:
                                            'https://play.google.com/store/apps/details?id=com.nhn.android.nmap&hl=ko&gl=US',
                                        appStoreLink:
                                            'https://apps.apple.com/kr/app/naver-map-navigation/id311867728?l=en-GB');
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
                                    child: Text(
                                      '네이버 지도로 길찾기'.tr,
                                      style: const TextStyle(
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
                                    controller.executeMap(
                                        type: 'suwon',
                                        mapNameEn: 'kakao_map',
                                        mapNameKr: '카카오맵',
                                        mapUri: suwonMapKakao,
                                        playStoreLink:
                                            'https://play.google.com/store/apps/details?id=net.daum.android.map&hl=ko&gl=US',
                                        appStoreLink:
                                            'https://apps.apple.com/kr/app/kakaomap-korea-no-1-map/id304608425?l=en-GB');
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
                                    child: Text(
                                      '카카오맵으로 길찾기'.tr,
                                      style: const TextStyle(
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
                          // 애플지도 추가1
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () async {
                                    controller.executeMap(
                                        type: 'suwon',
                                        mapNameEn: 'apple_map',
                                        mapNameKr: '애플 지도',
                                        mapUri: suwonMapApple,
                                        playStoreLink:
                                            'https://apps.apple.com/kr/app/maps/id915056765?l=en-GB',
                                        appStoreLink:
                                            'https://apps.apple.com/kr/app/maps/id915056765?l=en-GB');
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 173.w,
                                    height: 37.h,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      '애플 지도로 길찾기'.tr,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'NotoSansBold',
                                          fontSize: 13),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
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
                                '${'인자셔틀'.tr} ${'시간표'.tr} ${'[자과캠 → 인사캠]'.tr}',
                                style: const TextStyle(
                                  color: AppColors.green_main,
                                  fontFamily: 'NotoSansBold',
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
                                  rows: controller
                                      .schedule('suwon')
                                      .map((busTime) {
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
        ));
  }
}
