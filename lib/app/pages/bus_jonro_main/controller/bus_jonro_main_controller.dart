import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

/*
라이프사이클 감지 -> 화면이 다시 보일 때마다 데이터 갱신
*/
class JonroMainLifeCycle extends GetxController with WidgetsBindingObserver {
  JonroMainController busDataController = Get.find<JonroMainController>();

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
    if (state == AppLifecycleState.resumed) {}
  }
}

/*
메인 컨트롤러
*/

class JonroMainController extends GetxController {
  final currentTime = ''.obs; // 현재시간
  final activeBusCount = Rx<int?>(null); // 현재 운영중인 버스 대수
  Timer? _updateCurrentTime; // 현재시간을 10초마다 업데이트해주는 타이머

  // 종로07 버스 정류장 이름
  List<String> stationNames = [
    '명륜새마을금고',
    '서울국제고등학교',
    '국민생활관',
    '혜화 초등학교',
    '혜화우체국',
    '혜화역4번출구',
    '혜화역.서울대병원입구',
    '방송통신대앞',
    '이화사거리',
    '방송통신대.이화장',
    '혜화역.마로니에공원',
    '혜화역1번출구',
    '혜화동로터리',
    '성대입구',
    '성균관대 정문',
    '600주년 기념관',
    '성균관대운동장',
    '학생회관',
    '성균관대학교',
    '명륜새마을금고'
  ];

  @override
  void onInit() async {
    super.onInit();
    updateTime();
    _startTimer();
  }

  @override
  void onClose() {
    super.onClose();
    _updateCurrentTime?.cancel();
  }

  void _startTimer() {
    const duration = Duration(seconds: 10);
    _updateCurrentTime = Timer.periodic(duration, (Timer t) => updateTime());
  }

  void updateTime() {
    final format = DateFormat.jm(); // Output: hh:mm AM/PM
    currentTime.value = format.format(DateTime.now());
  }
}
