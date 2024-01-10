import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:live_activities/live_activities.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skkumap/app/pages/homepage/data/models/jongro_bus_model.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      snappingSheetController.snapToPosition(
        const SnappingPosition.factor(positionFactor: 0.5),
      );
      createPizzaActivity();

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
    });
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

  Future<void> fetchSecureStorage() async {
    name.value =
        await storage.read(key: 'local_name', iOptions: options) ?? '로그인해주세요';
    subname.value =
        await storage.read(key: 'local_branchGroup', iOptions: options) ?? '';
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
  }
}
