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

import 'package:skkumap/app/pages/homepage/data/models/jongro_bus_model.dart';

import 'hsscbus_controller.dart';
import 'jongrobus_controller.dart';
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
      // mainpageController.fetchIconImage();
      // mainpageController.checkpermission();
      mainpageController.jongro07BusMessage.value = "";
      mainpageController.jonro07BusMessageVisible.value = false;
      mainpageController.fetchhewaBusData();
      mainpageController.fetchhewaBusData2();
    }
    if (state == AppLifecycleState.inactive) {}
    if (state == AppLifecycleState.detached) {}
    if (state == AppLifecycleState.paused) {}
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

  // 인사캠 셔틀버스와 종로07 버스 정보 갱신해주는 타이머
  Timer? _timer10s;
  Timer? _timer30s;

  // 종로 07 자동 카운트다운해주는 타이머
  Timer? _countdownTimer;

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
      snaptoPosition();

      fetchIconImage();

      stationDataFetch();

      calculateRemainingStationsToHyehwaStation();
      calculateRemainingStationsToHyehwaStation2();

      fetchhewaBusData();

      fetchhewaBusData2();
      _timer10s = Timer.periodic(
          const Duration(seconds: 10), (Timer t) async => fetchhewaBusData());
      _timer30s = Timer.periodic(
          const Duration(seconds: 30), (Timer t) => fetchhewaBusData2());
    });
  }

  @override
  void onClose() {
    _timer10s?.cancel();
    _timer30s?.cancel();
    _countdownTimer?.cancel();
    super.onClose();
  }

  /// 인사캠 셔틀 정보 갱신
  Future<void> fetchhewaBusData() async {
    await calculateRemainingStationsToHyehwaStation();
  }

  /// 종로 07 정보 갱신
  Future<void> fetchhewaBusData2() async {
    jongro07BusMessage.value = "";
    jonro07BusMessageVisible.value = false;
    await calculateRemainingStationsToHyehwaStation2();
    _startCountdown();
  }

  // 종로 07 남은 시간 카운트다운
  void _startCountdown() {
    // Cancel the existing timer if it's already running
    if (_countdownTimer?.isActive ?? false) {
      _countdownTimer?.cancel();
    }

    // Start a new timer
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      // print("Timer tick: ${jongro07BusRemainTotalTimeSec.value}");
      if (jongro07BusRemainTotalTimeSec.value > 0) {
        jongro07BusRemainTotalTimeSec.value--;
      } else {
        t.cancel(); // Stop the timer if the countdown has finished
      }
    });
  }

  void fetchBusMap(List<JongroBusModel> itemList) {
    jongrobusMarker1.setIsVisible(false);
    jongrobusMarker2.setIsVisible(false);
    jongrobusMarker3.setIsVisible(false);
    jongrobusMarker4.setIsVisible(false);
    jongrobusMarker5.setIsVisible(false);

    List<NMarker> markers = [
      jongrobusMarker1,
      jongrobusMarker2,
      jongrobusMarker3,
      jongrobusMarker4,
      jongrobusMarker5
    ];

    for (int i = 0; i < markers.length; i++) {
      if (i < itemList.length) {
        var item = itemList[i];
        markers[i].setPosition(item.position);

        markers[i].setOnTapListener((overlay) async {
          await FlutterPlatformAlert.showCustomAlert(
            windowTitle: '종로07 버스',
            text: item.busNumber,
            negativeButtonTitle: "확인",
            // positiveButtonTitle: "취소",
          );
        });

        markers[i].setIsVisible(true);
      } else {
        markers[i].setIsVisible(false);
      }
    }
  }

  // 네이버 지도 마커 이미지 초기화
  Future<void> fetchIconImage() async {
    jongrobusMarker1.setIsVisible(false);
    jongrobusMarker2.setIsVisible(false);
    jongrobusMarker3.setIsVisible(false);
    jongrobusMarker4.setIsVisible(false);
    jongrobusMarker5.setIsVisible(false);

    jongrobusMarker1.setZIndex(100);
    jongrobusMarker2.setZIndex(101);
    jongrobusMarker3.setZIndex(102);
    jongrobusMarker4.setZIndex(103);
    jongrobusMarker5.setZIndex(104);

    jongrobusMarker1.setGlobalZIndex(100);
    jongrobusMarker2.setGlobalZIndex(101);
    jongrobusMarker3.setGlobalZIndex(102);
    jongrobusMarker4.setGlobalZIndex(103);
    jongrobusMarker5.setGlobalZIndex(104);
  }
}
