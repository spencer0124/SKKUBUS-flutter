import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:live_activities/live_activities.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

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

const double hewa1Lat = 37.583427;
const double hewa1Lon = 127.001850;

RxBool loadingdone = false.obs;

// 마커 값 초기화 안넣어주면 에러난다. 초기화 반드시 해주기
// 네이버 지도 관련 선언과 초기화

const iconImage = NOverlayImage.fromAssetImage(
  'assets/locationicon.png',
);

const busImage = NOverlayImage.fromAssetImage(
  'assets/jonrobus.png',
);

NMarker jongrobusMarker1 = NMarker(
  size: const Size(20, 20),
  id: 'jongrobusMarker1',
  position: const NLatLng(37.583427, 127.001850),
  icon: busImage,
);

NMarker jongrobusMarker2 = NMarker(
  size: const Size(20, 20),
  id: 'jongrobusMarker2',
  position: const NLatLng(37.583427, 127.001850),
  icon: busImage,
);

NMarker jongrobusMarker3 = NMarker(
  size: const Size(20, 20),
  id: 'jongrobusMarker3',
  position: const NLatLng(37.583427, 127.001850),
  icon: busImage,
);

NMarker jongrobusMarker4 = NMarker(
  size: const Size(20, 20),
  id: 'jongrobusMarker4',
  position: const NLatLng(37.583427, 127.001850),
  icon: busImage,
);

NMarker jongrobusMarker5 = NMarker(
  size: const Size(20, 20),
  id: 'jongrobusMarker5',
  position: const NLatLng(37.583427, 127.001850),
  icon: busImage,
);

NMarker station1 = NMarker(
  size: const Size(12, 12),
  id: 'station1',
  position: const NLatLng(37.587707, 126.996686),
  icon: iconImage,
);

NMarker station2 = NMarker(
  size: const Size(12, 12),
  id: 'station2',
  position: const NLatLng(37.589185, 126.9972903),
  icon: iconImage,
);

NMarker station3 = NMarker(
  size: const Size(12, 12),
  id: 'station3',
  position: const NLatLng(37.589829, 126.998893),
  icon: iconImage,
);

NMarker station4 = NMarker(
  size: const Size(12, 12),
  id: 'station4',
  position: const NLatLng(37.587254, 126.999908),
  icon: iconImage,
);

NMarker station5 = NMarker(
  size: const Size(12, 12),
  id: 'station5',
  position: const NLatLng(37.586098, 127.000658),
  icon: iconImage,
);

NMarker station6 = NMarker(
  size: const Size(12, 12),
  id: 'station6',
  position: const NLatLng(37.58350804, 127.0015539),
  icon: iconImage,
);

NMarker station7 = NMarker(
  size: const Size(12, 12),
  id: 'station7',
  position: const NLatLng(37.581117, 127.001914),
  icon: iconImage,
);

NMarker station8 = NMarker(
  size: const Size(12, 12),
  id: 'station8',
  position: const NLatLng(37.578845, 127.002061),
  icon: iconImage,
);

NMarker station9 = NMarker(
  size: const Size(12, 12),
  id: 'station9',
  position: const NLatLng(37.576628, 127.002098),
  icon: iconImage,
);

NMarker station10 = NMarker(
  size: const Size(12, 12),
  id: 'station10',
  position: const NLatLng(37.578149, 127.002411),
  icon: iconImage,
);

NMarker station11 = NMarker(
  size: const Size(12, 12),
  id: 'station11',
  position: const NLatLng(37.58111949, 127.0022769),
  icon: iconImage,
);

NMarker station12 = NMarker(
  size: const Size(12, 12),
  id: 'station12',
  position: const NLatLng(37.58348551, 127.0018454),
  icon: iconImage,
);

NMarker station13 = NMarker(
  size: const Size(12, 12),
  id: 'station13',
  position: const NLatLng(37.58558033, 127.0006878),
  icon: iconImage,
);

NMarker station14 = NMarker(
  size: const Size(12, 12),
  id: 'station14',
  position: const NLatLng(37.583323, 126.998977),
  icon: iconImage,
);

NMarker station15 = NMarker(
  size: const Size(12, 12),
  id: 'station15',
  position: const NLatLng(37.584897, 126.996569),
  icon: iconImage,
);

NMarker station16 = NMarker(
  size: const Size(12, 12),
  id: 'station16',
  position: const NLatLng(37.5873281, 126.9939426),
  icon: iconImage,
);

NMarker station17 = NMarker(
  size: const Size(12, 12),
  id: 'station17',
  position: const NLatLng(37.587943, 126.992523),
  icon: iconImage,
);

NMarker station18 = NMarker(
  size: const Size(12, 12),
  id: 'station18',
  position: const NLatLng(37.58744522, 126.9937417),
  icon: iconImage,
);

NMarker station19 = NMarker(
  size: const Size(12, 12),
  id: 'station19',
  position: const NLatLng(37.58516359, 126.9971922),
  icon: iconImage,
);

NMarker station20 = NMarker(
  size: const Size(12, 12),
  id: 'station20',
  position: const NLatLng(37.587707, 126.996686),
  icon: iconImage,
);

NPathOverlay testRoute = NPathOverlay(
  id: "test",
  coords: [
    const NLatLng(37.58778547, 126.9967901477),
    const NLatLng(37.58778547, 126.9967901477),
  ],
);

NMultipartPathOverlay jongroRoute =
    NMultipartPathOverlay(id: "jongroRoute", paths: [
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
      NLatLng(37.584859, 126.995868),
      NLatLng(37.584886, 126.995694),
      NLatLng(37.585028, 126.995540),
      NLatLng(37.5873281, 126.9939426), // 600주년기념관
      NLatLng(37.588045, 126.993413),
      NLatLng(37.588560, 126.993053),
      NLatLng(37.588137, 126.992209),
      NLatLng(37.587943, 126.992523), // 성균관대운동장
      NLatLng(37.587437, 126.992650),
      NLatLng(37.587450, 126.992768),
      NLatLng(37.587744, 126.993470),
      NLatLng(37.587705, 126.993536),
      NLatLng(37.58744522, 126.9937417), // 학생회관
      NLatLng(37.584865, 126.995611),
      NLatLng(37.584811, 126.995696),
      NLatLng(37.584787, 126.995797),
      NLatLng(37.584893, 126.997181),
      NLatLng(37.58516359, 126.9971922), // 성균관대학교
      NLatLng(37.586414, 126.996755),
      NLatLng(37.587180, 126.996577),
      NLatLng(37.587707, 126.996686), // 명륜새마을금고
    ],
  ),
]);

class MainpageController extends GetxController {
  // 라이브 액티비티 관련
  final LiveActivities _liveActivitiesPlugin = LiveActivities();

  // 메인화면 스크롤 컨트롤러
  final snappingSheetController = SnappingSheetController();

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

  // 사이드바에 표출되는 이름과 sub이름
  RxString name = '로그인해주세요'.obs;
  RxString subname = ''.obs;

  // 네이버 지도 오버레이 초기화
  late NOverlayImage iconImage;

  // 인사캠 셔틀버스와 종로07 버스 정보 갱신해주는 타이머
  Timer? _timer10s;
  Timer? _timer30s;

  // 종로 07 자동 카운트다운해주는 타이머
  Timer? _countdownTimer;

  // live activity 관련
  String? activityId;

  @override
  void onInit() {
    super.onInit();

    if (Platform.isIOS) {
      _liveActivitiesPlugin.init(appGroupId: "group.flutterioswidget1");
    }

    createPizzaActivity();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      snappingSheetController.snapToPosition(
        const SnappingPosition.factor(positionFactor: 0.5),
      );
    });

    // waitForAttachment(); // attach 된 후에 snaptoposition해주기

    fetchIconImage();
    // checkpermission();
    calculateRemainingStationsToHyehwaStation();
    calculateRemainingStationsToHyehwaStation2();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   fetchSecureStorage();
    // }); // 의도한대로 작동 안해서 그냥 사이드바 열때 securestorage fetch하도록 함
    // fetchIconImage();
    fetchSecureStorage();
    fetchhewaBusData();
    // jongro07BusMessage.value = "";
    // jonro07BusMessageVisible.value = false;
    fetchhewaBusData2();
    _timer10s = Timer.periodic(
        const Duration(seconds: 10), (Timer t) async => fetchhewaBusData());
    _timer30s = Timer.periodic(
        const Duration(seconds: 30), (Timer t) => fetchhewaBusData2());
  }

  void createPizzaActivity() async {
    final Map<String, dynamic> activityModel = {
      'name': 'Margherita',
      'ingredient': 'tomato, mozzarella, basil',
      'quantity': 1,
    };

    _liveActivitiesPlugin.createActivity(activityModel);
  }

  // void waitForAttachment() {
  //   Timer.periodic(const Duration(milliseconds: 100), (Timer timer) {
  //     if (snappingSheetController.isAttached) {
  //       timer.cancel();
  //       snapSheetToPosition();
  //     }
  //   });
  // }

  // void snapSheetToPosition() {
  //   snappingSheetController.snapToPosition(
  //     const SnappingPosition.factor(positionFactor: 0.5),
  //   );
  // }

  @override
  void onClose() {
    _timer10s?.cancel();
    _timer30s?.cancel();
    _countdownTimer?.cancel();
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
    // 인사캠 셔틀 정보 갱신
    print('fetchhewaBusData1');
    await calculateRemainingStationsToHyehwaStation();
  }

  Future<void> fetchhewaBusData2() async {
    // 종로 07 정보 갱신
    jongro07BusMessage.value = "";
    jonro07BusMessageVisible.value = false;
    print('fetchhewaBusData2');
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

  Future<void> fetchSecureStorage() async {
    name.value =
        await storage.read(key: 'local_name', iOptions: options) ?? '로그인해주세요';
    subname.value =
        await storage.read(key: 'local_branchGroup', iOptions: options) ?? '';
  }

  void fetchBusInit() {
    jongrobusMarker1.setIsVisible(false);
    jongrobusMarker2.setIsVisible(false);
    jongrobusMarker3.setIsVisible(false);
    jongrobusMarker4.setIsVisible(false);
    jongrobusMarker5.setIsVisible(false);
  }

  void fetchBusMap(List<dynamic> itemList) {
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
        double posX = double.parse(item['tmY']);
        double posY = double.parse(item['tmX']);

        markers[i].setPosition(
          NLatLng(posX, posY),
        );

        markers[i].setOnTapListener((overlay) async {
          await FlutterPlatformAlert.showCustomAlert(
            windowTitle: '종로07 버스',
            text: item['plainNo'],
            negativeButtonTitle: "확인",
            // positiveButtonTitle: "취소",
          );
        });

        markers[i].setIsVisible(true);
      } else {
        markers[i].setIsVisible(false);
      }
    }

    // Update the map to reflect changes
    // Implement the logic to refresh the map view if necessary
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

    station1.setZIndex(1);
    station2.setZIndex(2);
    station3.setZIndex(3);
    station4.setZIndex(4);
    station5.setZIndex(5);
    station6.setZIndex(6);
    station7.setZIndex(7);
    station8.setZIndex(8);
    station9.setZIndex(9);
    station10.setZIndex(10);
    station11.setZIndex(11);
    station12.setZIndex(12);
    station13.setZIndex(13);
    station14.setZIndex(14);
    station15.setZIndex(15);
    station16.setZIndex(16);
    station17.setZIndex(17);
    station18.setZIndex(18);
    station19.setZIndex(19);
    station20.setZIndex(20);

    station1.setGlobalZIndex(1);
    station2.setGlobalZIndex(2);
    station3.setGlobalZIndex(3);
    station4.setGlobalZIndex(4);
    station5.setGlobalZIndex(5);
    station6.setGlobalZIndex(6);
    station7.setGlobalZIndex(7);
    station8.setGlobalZIndex(8);
    station9.setGlobalZIndex(9);
    station10.setGlobalZIndex(10);
    station11.setGlobalZIndex(11);
    station12.setGlobalZIndex(12);
    station13.setGlobalZIndex(13);
    station14.setGlobalZIndex(14);
    station15.setGlobalZIndex(15);
    station16.setGlobalZIndex(16);
    station17.setGlobalZIndex(17);
    station18.setGlobalZIndex(18);
    station19.setGlobalZIndex(19);
    station20.setGlobalZIndex(20);

    loadingdone.value = true;
  }
}
