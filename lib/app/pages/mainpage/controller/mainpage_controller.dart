import 'snappingsheet_controller.dart';
import 'package:skkumap/app/pages/homepage/ui/navermap.dart';

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
    }
  }
}

const options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);
AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

class MainpageController extends GetxController {
  // 내가 만든 api 테스트 우하하
  var stationData = Rx<StationResponse?>(null);

  // 혜화역 1번 출구 - 종로 07 정보
  RxInt jongro07BusRemainTimeMin = 0.obs;
  RxInt jongro07BusRemainTimeSec = 0.obs;
  RxInt jongro07BusRemainTotalTimeSec = 0.obs;
  RxInt jongro07BusRemainStation = 0.obs;
  RxString jongro07BusMessage = "".obs;
  RxBool jonro07BusMessageVisible = false.obs;

  RxBool jonroLoadingDone = false.obs;

  // 혜화역 1번 출구 - 인사캠 셔틀버스 정보
  // var hsscBusRemainTime = 0.obs;
  RxInt hsscBusRemainStation = 0.obs;
  RxString hsscBusMessage = ''.obs;

  Future<void> stationDataFetch() async {
    try {
      stationData.value = await fetchStationData('123');
    } catch (e) {
      // print('Error fetching data: $e');
    }
  }

  @override
  void onInit() async {
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      snaptoInitPosition();
      stationDataFetch();
    });
  }
}
