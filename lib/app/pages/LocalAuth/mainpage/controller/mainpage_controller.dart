import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'hsscbus_controller.dart';
import 'jongrobus_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

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
      mainpageController.checkpermission();
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

const double hewa1Lat = 37.583427;
const double hewa1Lon = 127.001850;

RxBool loadingdone = false.obs;

late var jongrobusMarker1;
late var jongrobusMarker2;
late var jongrobusMarker3;
late var jongrobusMarker4;

late var station1;
late var station2;
late var station3;
late var station4;
late var station5;
late var station6;
late var station7;
late var station8;
late var station9;
late var station10;
late var station11;
late var station12;
late var station13;
late var station14;
late var station15;
late var station16;
late var station17;
late var station18;
late var station19;
late var station20;

late var markerinfo;
late var jongroRoute;
late var testRoute;

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
  Timer? _timer10s;
  Timer? _timer30s;

  @override
  void onInit() {
    super.onInit();
    checkpermission();
    calculateRemainingStationsToHyehwaStation();
    calculateRemainingStationsToHyehwaStation2();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   fetchSecureStorage();
    // }); // 의도한대로 작동 안해서 그냥 사이드바 열때 securestorage fetch하도록 함
    // fetchIconImage();
    fetchSecureStorage();
    fetchhewaBusData();
    _timer10s = Timer.periodic(
        const Duration(seconds: 10), (Timer t) async => fetchhewaBusData());
    _timer30s = Timer.periodic(
        const Duration(seconds: 30), (Timer t) => fetchhewaBusData2());
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is disposed
    _timer10s?.cancel();
    _timer30s?.cancel();
    super.onClose();
  }

  Future<void> checkpermission() async {
    await Permission.location.request();
    var locationpermission = await Permission.location.status;
    if (locationpermission.isDenied) {
      // await openAppSettings();
      await FlutterPlatformAlert.showAlert(
        windowTitle: 'denied',
        text: '1',
        alertStyle: AlertButtonStyle.ok,
      );
      var result = await Permission.location.request();
      await FlutterPlatformAlert.showAlert(
        windowTitle: result.toString(),
        text: '2',
        alertStyle: AlertButtonStyle.ok,
      );
    }
    if (locationpermission.isPermanentlyDenied) {
      await FlutterPlatformAlert.showAlert(
        windowTitle: 'per-denied',
        text: '3',
        alertStyle: AlertButtonStyle.ok,
      );
      await openAppSettings();
    } else {
      await FlutterPlatformAlert.showAlert(
        windowTitle: locationpermission.toString(),
        text: '1',
        alertStyle: AlertButtonStyle.ok,
      );
    }
  }

  Future<void> fetchhewaBusData() async {
    print('hewa data fetch1');
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

  Future<void> fetchhewaBusData2() async {
    // 종로07 혜화역 1번 출구 남은 시간 및 정류장 정보 가져오기와, 위치 표현해주는 함수
    print('hewa data fetch2');
    calculateRemainingStationsToHyehwaStation2();
  }

  Future<void> fetchSecureStorage() async {
    name.value =
        await storage.read(key: 'local_name', iOptions: options) ?? '로그인해주세요';
    subname.value =
        await storage.read(key: 'local_branchGroup', iOptions: options) ?? '';
  }

  Future<void> fetchIconImage(BuildContext context) async {
    const iconImage = NOverlayImage.fromAssetImage(
      'assets/locationicon.png',
    );

    station2 = NMarker(
      size: const Size(18, 18),
      id: 'station2',
      position: const NLatLng(37.589185, 126.9972903),
      icon: iconImage,
    );

    station3 = NMarker(
      size: const Size(18, 18),
      id: 'station3',
      position: const NLatLng(37.589829, 126.998893),
      icon: iconImage,
    );

    station4 = NMarker(
      size: const Size(18, 18),
      id: 'station4',
      position: const NLatLng(37.587254, 126.999908),
      icon: iconImage,
    );

    station5 = NMarker(
      size: const Size(18, 18),
      id: 'station5',
      position: const NLatLng(37.586098, 127.000658),
      icon: iconImage,
    );

    station6 = NMarker(
      size: const Size(18, 18),
      id: 'station6',
      position: const NLatLng(37.58350804, 127.0015539),
      icon: iconImage,
    );

    station7 = NMarker(
      size: const Size(18, 18),
      id: 'station7',
      position: const NLatLng(37.581117, 127.001914),
      icon: iconImage,
    );

    station8 = NMarker(
      size: const Size(18, 18),
      id: 'station8',
      position: const NLatLng(37.578845, 127.002061),
      icon: iconImage,
    );

    station9 = NMarker(
      size: const Size(18, 18),
      id: 'station9',
      position: const NLatLng(37.576628, 127.002098),
      icon: iconImage,
    );

    station10 = NMarker(
      size: const Size(18, 18),
      id: 'station10',
      position: const NLatLng(37.578149, 127.002411),
      icon: iconImage,
    );

    station11 = NMarker(
      size: const Size(18, 18),
      id: 'station11',
      position: const NLatLng(37.58111949, 127.0022769),
      icon: iconImage,
    );

    station12 = NMarker(
      size: const Size(18, 18),
      id: 'station12',
      position: const NLatLng(37.58348551, 127.0018454),
      icon: iconImage,
    );

    station13 = NMarker(
      size: const Size(18, 18),
      id: 'station13',
      position: const NLatLng(37.58558033, 127.0006878),
      icon: iconImage,
    );

    station14 = NMarker(
      size: const Size(18, 18),
      id: 'station14',
      position: const NLatLng(37.583323, 126.998977),
      icon: iconImage,
    );

    station15 = NMarker(
      size: const Size(18, 18),
      id: 'station15',
      position: const NLatLng(37.584897, 126.996569),
      icon: iconImage,
    );

    station16 = NMarker(
      size: const Size(18, 18),
      id: 'station16',
      position: const NLatLng(37.5873281, 126.9939426),
      icon: iconImage,
    );

    station17 = NMarker(
      size: const Size(18, 18),
      id: 'station17',
      position: const NLatLng(37.5878641, 126.9923688),
      icon: iconImage,
    );

    station18 = NMarker(
      size: const Size(18, 18),
      id: 'station18',
      position: const NLatLng(37.58744522, 126.9937417),
      icon: iconImage,
    );

    station19 = NMarker(
      size: const Size(18, 18),
      id: 'station19',
      position: const NLatLng(37.58516359, 126.9971922),
      icon: iconImage,
    );

    station20 = NMarker(
      size: const Size(18, 18),
      id: 'station20',
      position: const NLatLng(37.587707, 126.996686),
      icon: iconImage,
    );

    testRoute = NPathOverlay(
      id: "test",
      coords: [
        const NLatLng(37.58778547, 126.9967901477),
        const NLatLng(37.58778547, 126.9967901477),
      ],
    );

    jongroRoute = NMultipartPathOverlay(id: "jongroRoute", paths: [
      const NMultipartPath(
        color: Colors.green,
        outlineColor: Colors.white,
        coords: [
          NLatLng(37.587707, 126.996686), // 명륜새마을금고
          NLatLng(37.588855, 126.997132),
          NLatLng(37.589185, 126.9972903), // 서울국제고등학교
          NLatLng(37.589357, 126.997549),
          NLatLng(37.589500, 126.997870),
          NLatLng(37.589568, 126.998056),
          NLatLng(37.589706, 126.998256),
          NLatLng(37.589971, 126.998522),
          NLatLng(37.589829, 126.998893), // 국민생활관
          NLatLng(37.589770, 126.999042),
          NLatLng(37.589693, 126.999167),
          NLatLng(37.587509, 126.999820),
          NLatLng(37.587254, 126.999908), // 혜화초등학교
          NLatLng(37.587038, 126.999991),
          NLatLng(37.586713, 127.000137),
          NLatLng(37.586431, 127.000352),
          NLatLng(37.586098, 127.000658), // 혜화 우체국
          NLatLng(37.585853, 127.000881),
          NLatLng(37.585762, 127.000994),
          NLatLng(37.585673, 127.000915),
          NLatLng(37.585555, 127.000874),
          NLatLng(37.585479, 127.000884),
          NLatLng(37.585383, 127.000910),
          NLatLng(37.585270, 127.001113),
          NLatLng(37.585218, 127.001249),
          NLatLng(37.58350804, 127.0015539), // 혜화역 4번 출구
          NLatLng(37.582397, 127.001747),
          NLatLng(37.581117, 127.001914), // 혜화역, 서울대병원입구
          NLatLng(37.579733, 127.002032),
          NLatLng(37.578845, 127.002061), // 방송통신대앞 - 회차
          NLatLng(37.576628, 127.002098), // 이화사거리
          NLatLng(37.576569, 127.002472),
          NLatLng(37.578149, 127.002411), // 방송통신대.이화장
          NLatLng(37.58111949, 127.0022769), // 혜화역.마로니에공원
          NLatLng(37.58348551, 127.0018454), // 혜화역1번출구
          NLatLng(37.585252, 127.001476),
          NLatLng(37.585447, 127.001537),
          NLatLng(37.585639, 127.001500),
          NLatLng(37.585793, 127.001334),
          NLatLng(37.585815, 127.001127),
          NLatLng(37.585746, 127.000966),
          NLatLng(37.585634, 127.000876),
          NLatLng(37.58558033, 127.0006878), // 혜화동로터리
          NLatLng(37.585496, 127.000855),
          NLatLng(37.585348, 127.000909),

          NLatLng(37.583323, 126.998977), // 성대입구
          NLatLng(37.583151, 126.998708),
          NLatLng(37.583514, 126.998353),

          NLatLng(37.584236, 126.997634),

          NLatLng(37.584915, 126.997237),
          NLatLng(37.584897, 126.996569), // 성균관대정문
          NLatLng(37.5873281, 126.9939426), // 600주년기념관
          NLatLng(37.5878641, 126.9923688), // 성균관대운동장
          NLatLng(37.58744522, 126.9937417), // 학생회관
          NLatLng(37.58516359, 126.9971922), // 성균관대학교
          NLatLng(37.587707, 126.996686), // 명륜새마을금고
        ],
      ),
    ]);

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
