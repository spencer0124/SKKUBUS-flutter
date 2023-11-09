import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'hsscbus_controller.dart';
import 'jongrobus_controller.dart';

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
      mainpageController.fetchhewaBusData();
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

const double hewa1Lat = 37.583427;
const double hewa1Lon = 127.001850;

RxBool loadingdone = false.obs;

late var seoulMarker;
late var markerinfo;

class MainpageController extends GetxController {
  // 혜화역 1번 출구 정보를 담는 변수
  RxInt jongro07BusRemainTimeMin = 0.obs;
  RxInt jongro07BusRemainTimeSec = 0.obs;
  RxInt jongro07BusRemainStation = 0.obs;
  RxString jongro07BusMessage = ''.obs;
  // var hsscBusRemainTime = 0.obs;

  RxInt hsscBusRemainStation = 0.obs;
  RxString hsscBusRemainStationName = ''.obs;

  RxString name = '로그인해주세요'.obs;
  RxString subname = ''.obs;
  late NOverlayImage iconImage;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   fetchSecureStorage();
    // }); // 의도한대로 작동 안해서 그냥 사이드바 열때 securestorage fetch하도록 함
    fetchIconImage();
    fetchSecureStorage();
    fetchhewaBusData();
    _timer = Timer.periodic(
        const Duration(seconds: 12), (Timer t) => fetchhewaBusData());
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is disposed
    _timer?.cancel();
    super.onClose();
  }

  Future<void> fetchhewaBusData() async {
    calculateRemainingStationsToHyehwaStation2();
    print('hewa data fetch');
    hsscBusRemainStation.value =
        await calculateRemainingStationsToHyehwaStation();

    switch (hsscBusRemainStation.value) {
      case 0:
        hsscBusRemainStationName.value = '당역 도착';
        break;
      case 1:
        hsscBusRemainStationName.value = '혜화역U턴지점';
        break;
      case 2:
        hsscBusRemainStationName.value = '혜화로터리(하차지점)';
        break;
      case 3:
        hsscBusRemainStationName.value = '정문(인문-하교)';
        break;
      case 4:
        hsscBusRemainStationName.value = '학생회관(인문)';
        break;
      case 5:
        hsscBusRemainStationName.value = '정차소(인문.농구장)';
        break;
      default:
        hsscBusRemainStationName.value = '정보없음';
        break;
    }
  }

  Future<void> fetchSecureStorage() async {
    name.value =
        await storage.read(key: 'local_name', iOptions: options) ?? '로그인해주세요';
    subname.value =
        await storage.read(key: 'local_branchGroup', iOptions: options) ?? '';
  }

  Future<void> fetchIconImage() async {
    // iconImage = await createIconImage();
    // update(); // if you're using GetBuilder, otherwise not needed for Obx
    seoulMarker = NMarker(
      id: 'seoul_marker',
      position: const NLatLng(hewa1Lat, hewa1Lon),

      // icon: iconImage,
      // icon: controller.iconImage,
    );

    // markerinfo =
    //     NInfoWindow.onMarker(id: 'seoul_marker', text: '인사캠 셔틀 \\ 종로07');
    // seoulMarker.openInfoWindow(markerinfo);
    loadingdone.value = true;
  }

  Future<NOverlayImage> createIconImage() async {
    // Use the context from the nearest ancestor GetMaterialApp or GetBuilder
    final context = Get.context!;
    return await NOverlayImage.fromWidget(
      widget: const FlutterLogo(),
      size: const Size(24, 24),
      context: context,
    );
  }
}
