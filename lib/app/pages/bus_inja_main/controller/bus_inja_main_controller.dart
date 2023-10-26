import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'dart:io' show Platform;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> initEnvironmentVariables() async {
  await dotenv.load(fileName: ".env");
}

/*
LifeCycleGetx2, WidgetsBindingObserver
라이프사이클을 이용해 앱이 백그라운드에서 포그라운드로 돌아올때 
탑승 가능한 가장 빠른 버스 시간을 표시하기 위한 로직
 */

class InjaMainLifeCycle extends GetxController with WidgetsBindingObserver {
  InjaMainController injaMainController = Get.find<InjaMainController>();

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
      injaMainController.determineNextBus();
    }
  }
}

/*
ESKARAController
메인 컨트롤러
*/
class InjaMainController extends GetxController {
  // currentTime

  @override
  void onInit() async {
    await initEnvironmentVariables();
    getDrivingDuration();
    try {
      await FirebaseAnalytics.instance
          .setCurrentScreen(screenName: 'injashuttle_screen');
    } catch (e) {
      print(e);
    }
    super.onInit();
    determineNextBus();
  }

  var duration = ''.obs;

  final Dio _dio = Dio();

  // 인자셔틀 이동 소요시간 체크해주는 함수
  Future<void> getDrivingDuration() async {
    try {
      final response = await _dio.get(
        'https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving?start=126.993688,37.587308&goal=126.975532,37.292345',
        options: Options(
          headers: {
            'X-NCP-APIGW-API-KEY-ID': dotenv.env['naverClientId'],
            'X-NCP-APIGW-API-KEY': dotenv.env['naverClientSecret'],
          },
        ),
      );

      final data = response.data;
      if (data['code'] == 0) {
        final durationInMillis =
            data['route']['traoptimal'][0]['summary']['duration'];
        final durationInHours = (durationInMillis / (1000 * 60 * 60)).floor();
        final durationInMinutes =
            ((durationInMillis % (1000 * 60 * 60)) / (1000 * 60)).floor();

        duration.value = '$durationInHours시간 $durationInMinutes분';
      } else {
        // Handle API error or any other condition as per your requirement
        print('error1');
      }
    } catch (e) {
      // Handle Dio exception or any other exception as per your requirement
      print(e);
    }
  }

  // 지도 앱 실행 가능한지 확인 후 분기처리해주는 함수
  Future<void> executeMap({
    required String type,
    required String mapNameEn,
    required String mapNameKr,
    required Uri mapUri,
    required String playStoreLink,
    required String appStoreLink,
  }) async {
    FirebaseAnalytics.instance.logEvent(
      name: 'injashuttle_${type}_$mapNameEn',
    );

    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri);

      FirebaseAnalytics.instance.logEvent(
        name: 'injashuttle_${type}_${mapNameEn}_success',
      );
    } else {
      final result = await FlutterPlatformAlert.showCustomAlert(
        windowTitle: '$mapNameKr가 설치되어 있지 않아요',
        text: '$mapNameKr 설치 페이지로 이동할까요?',
        negativeButtonTitle: "이동",
        positiveButtonTitle: "취소",
      );

      if (result == CustomButton.positiveButton) {
        FirebaseAnalytics.instance.logEvent(
          name: 'injashuttle_${type}_${mapNameEn}_fail_cancel',
        );
      }

      if (result == CustomButton.negativeButton) {
        FirebaseAnalytics.instance.logEvent(
          name: 'injashuttle_${type}_${mapNameEn}_fail_move',
        );
        if (Platform.isAndroid) {
          if (await canLaunchUrl(Uri.parse(playStoreLink))) {
            await launchUrl(Uri.parse(playStoreLink));
          }
        }
        if (Platform.isIOS) {
          if (await canLaunchUrl(Uri.parse(appStoreLink))) {
            await launchUrl(Uri.parse(appStoreLink));
          }
        }
      }
    }
  }

  // 인자셔틀 시간표 (가능한 시간 목록). 금요일과 금요일이 아닌 경우 분리
  // 인사캠 -> 자과캠
  final List<String> seoulBasicBusTimes = [
    '07:00',
    '10:00',
    '12:00',
    '15:00',
    '16:30',
    '18:00',
    '19:00'
  ];

  final List<String> seoulFridayBusTimes = [
    '08:00',
    '10:00',
    '12:00',
    '14:00',
    '15:00',
    '16:20',
    '16:30',
    '18:00',
    '18:10',
    '19:00',
  ];

  // 자과캠 -> 인사캠
  final List<String> suwonBasicBusTimes = [
    '07:00',
    '10:30',
    '12:00',
    '13:30',
    '15:00',
    '16:30',
    '18:00',
  ];

  final List<String> suwonFridayBusTimes = [
    '08:00',
    '10:00',
    '10:30',
    '12:00',
    '13:30',
    '14:00',
    '15:00',
    '16:20',
    '16:30',
    '18:00',
    '18:10',
  ];

  // 다음 버스 시간 저장하는 변수
  var seoulNextBusTime = ''.obs;
  var suwonNextBusTime = ''.obs;

  // 탑승 가능한 가장 빠른 시간을 찾아주는 함수
  String determineNextTime(String currentTime, List<String> busTimes) {
    return busTimes.firstWhere(
      (busTime) => busTime.compareTo(currentTime) > 0,
      orElse: () => 'No more buses available today',
    );
  }

  // 금요일인지 아닌지에 따라 분기처리 후 determineNextTime 함수 호출
  void determineNextBus() {
    DateTime now = DateTime.now().toLocal();
    String formattedTime = DateFormat('HH:mm').format(now);
    if (now.weekday == DateTime.saturday || now.weekday == DateTime.sunday) {
    } else if (now.weekday == DateTime.friday) {
      seoulNextBusTime.value =
          determineNextTime(formattedTime, seoulFridayBusTimes);
      suwonNextBusTime.value =
          determineNextTime(formattedTime, suwonFridayBusTimes);
    } else {
      seoulNextBusTime.value =
          determineNextTime(formattedTime, seoulBasicBusTimes);
      suwonNextBusTime.value =
          determineNextTime(formattedTime, suwonBasicBusTimes);
    }
  }

  List<String> schedule(String location) {
    DateTime now = DateTime.now().toLocal();
    if (location == 'seoul') {
      if (now.weekday != DateTime.friday) {
        return seoulBasicBusTimes;
      } else {
        return seoulFridayBusTimes;
      }
    } else {
      if (now.weekday != DateTime.friday) {
        return suwonBasicBusTimes;
      } else {
        return suwonFridayBusTimes;
      }
    }
  }
}
