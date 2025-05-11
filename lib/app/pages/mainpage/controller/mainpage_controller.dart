import 'snappingsheet_controller.dart';
import 'package:skkumap/app/pages/mainpage/ui/navermap/navermap.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:skkumap/app/model/station_model.dart';
import 'package:skkumap/app/utils/api_fetch/fetch_station.dart';
import 'package:skkumap/app/utils/api_fetch/mainpage_buslist.dart';
import 'package:skkumap/app/model/mainpage_buslist_model.dart';
import 'package:flutter_udid/flutter_udid.dart';

class MainpageLifeCycle extends GetxController with WidgetsBindingObserver {
  MainpageController mainpageController = Get.find<MainpageController>();

  final controller = Get.find<MainpageController>();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // 여기에 화면에 돌아왔을때 사용할 코드 작성하기
      mainpageController.mainPageBusListFetch();
      mainpageController.stationDataFetch();
      mainpageController.fetchMainpageAd();
    }
  }
}

class MainpageController extends GetxController {
  var snappingSheetIsExpanded = false.obs;

  Timer? _timer;

  // BottomNavigation 현재 선택된 index 저장
  var bottomNavigationIndex = 0.obs;

  // 필터에서 선택된 캠퍼스, 필터에서 선택된 캠퍼스 정보
  // 0: 인사캠, 1: 자과캠
  var selectedCampus = 0.obs;
  // 옵션 순서대로 0, 1, ...
  var selectedCampusInfo = [0, 1].obs;
  final List<Map<String, dynamic>> campusInfo = [
    {"text": "버스", "index": 0},
    {"text": "건물번호", "index": 1},
    {"text": "교내식당", "index": 2},
    {"text": "교내매점", "index": 3},
    {"text": "편의점", "index": 4},
    {"text": "커피", "index": 5},
    {"text": "은행", "index": 6},
    {"text": "ATM", "index": 7},
    {"text": "우체국", "index": 8},
    {"text": "프린트", "index": 9},
    {"text": "자판기", "index": 10},
    {"text": "제세동기", "index": 11},
    {"text": "복사실", "index": 12},
  ];

  // 정류장 정보를 담을 변수
  var stationData = Rx<StationResponse?>(null);

  Future<void> stationDataFetch() async {
    try {
      stationData.value = await fetchStationData('01592');

      // print("===================================");
      // print(
      // 'stationDataFetch, stationData.value: ${stationData.value!.stationData}');
      // print("===================================");
    } catch (e) {
      // print('Error fetching data: $e');
    }
  }

  var mainpageBusList = Rx<MainPageBusListResponse?>(null);

  Future<void> mainPageBusListFetch() async {
    try {
      mainpageBusList.value = await fetchMainpageBusList();
      // print(
      // 'MainPageBusListFetch, mainpageBusList.value: ${mainpageBusList.value!.busList}');
    } catch (e) {
      // print('Error fetching data: $e');
    }
  }

  var fetchMainpageAdbool = false;

  // 메인화면 광고 텍스트 불러오기
  var showmainpageAdText = false.obs;
  var mainpageAdText = ''.obs;
  var mainpageAdLink = ''.obs;
  var showmainpageNoticeText = false.obs;
  var mainpageNoticeText = ''.obs;
  var mainpageNoticeLink = ''.obs;

  void fetchMainpageAd() async {
    try {
      final response = await http.get(Uri.parse(
          // 'http://localhost:3000/ad/v1/addetail'));
          'http://43.200.90.214:3000/ad/v1/addetail'));

      if (response.statusCode == 200) {
        if (fetchMainpageAdbool == false) {
          try {
            http.get(Uri.parse(
                'http://43.200.90.214:3000/ad/v1/statistics/menu2/view'));
          } catch (e) {
            print('Error: $e');
          }

          fetchMainpageAdbool = true;
        }

        final data = jsonDecode(response.body);
        mainpageAdText.value = data['text'];
        mainpageAdLink.value = data['link'];
        showmainpageAdText.value = data['showtext'];

        mainpageNoticeText.value = data['text2'];
        // mainpageNoticeLink.value = data['link2'];
        showmainpageNoticeText.value = data['showtext2'];
      } else {
        print('Server error2');
      }
    } catch (e) {
      print('Error: $e');
    }

    String udid = await FlutterUdid.consistentUdid;
    // print("===================================");
    // print(udid);
    // print("===================================");

    // print('http://10.0.2.2:3000/poll/v1/register/$udid');
    try {
      final response = await http.get(Uri.parse(
          // 'http://ec2-13-209-48-107.ap-northeast-2.compute.amazonaws.com/ad/v1/addetail/$udid'
          'http://43.200.90.214:3000/poll/v1/register/$udid'));
      // 'http://10.0.2.2:3000/poll/v1/register/$udid'));
      // 'http://localhost:3000/poll/v1/register/$udid'));
      // ));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // print("data:${jsonEncode(data)}");

        mainpageNoticeLink.value = data['link2'];
      } else {
        print('Server error3');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    fetchMainpageAd();
    stationDataFetch();
    await mainPageBusListFetch();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      snaptoInitPosition();
      _timer = Timer.periodic(
        const Duration(seconds: 15),
        (Timer t) {
          stationDataFetch();
          fetchMainpageAd();
        },
      );
    });
  }
}
