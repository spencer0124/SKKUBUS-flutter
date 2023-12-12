import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skkumap/app/pages/mainpage/controller/mainpage_controller.dart';
import 'package:skkumap/app/pages/mainpage/data/repositories/jongro_bus_repository.dart';

/*
라이프사이클 감지 -> 화면이 다시 보일 때마다 데이터 갱신
*/
class JonroMainLifeCycle extends GetxController with WidgetsBindingObserver {
  JonroMainController controller = Get.find<JonroMainController>();

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
      controller.fetchJonrobusApi();
    }
  }
}

/*
메인 컨트롤러
*/

class JonroMainController extends GetxController {
  MainpageController controller = Get.find<MainpageController>();
  RxBool loading = true.obs;
  final currentTime = ''.obs; // 현재시간
  RxInt activeBusCount = 0.obs; // 현재 운영중인 버스 대수
  Timer? _updateCurrentTime; // 현재시간을 10초마다 업데이트해주는 타이머
  Timer? _updateBusApi; // 버스 정보를 30초마다 업데이트해주는 타이머

  // 종로07 버스 정류장 이름
  // 19개
  List<String> stationNames = [
    '명륜새마을금고',
    '서울국제고등학교',
    '국민생활관',
    '혜화초등학교',
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
  ];

  // 명륜새마일금고(100900197) 1번 -> 19개
  List<int> stationNodeId = [
    100900197,
    100900031,
    100900017,
    100900003,
    100900063,
    100900027,
    100000125,
    100900028,
    100900043,
    100000123,
    100000124,
    100900075,
    100000130,
    100900199,
    100900218,
    100900219,
    100900220,
    100900221,
    100900110,
  ];

  var arrmsg1 = RxList<String>(List.filled(19, '도착 정보 없음'));
  var arrmsg2 = RxList<String>(List.filled(19, '도착 정보 없음'));
  var flag = RxList<int>(List.filled(19, 0));
  var busNum = RxList<String>(List.filled(19, '00000'));

  @override
  void onInit() async {
    super.onInit();
    updateTime();
    fetchJonrobusApi();
    _startTimer();
  }

  @override
  void onClose() {
    super.onClose();
    _updateCurrentTime?.cancel();
    _updateBusApi?.cancel();
  }

  // 10초마다 현재 시간 업데이트
  void _startTimer() {
    const duration = Duration(seconds: 10);
    _updateCurrentTime = Timer.periodic(duration, (Timer t) => updateTime());

    const duration2 = Duration(seconds: 30);
    _updateBusApi = Timer.periodic(duration2, (Timer t) => fetchJonrobusApi());
  }

  // 실제로 현재 시간을 가져오는 부분
  void updateTime() {
    final format = DateFormat.jm();
    currentTime.value = format.format(DateTime.now());
  }

  // 종로07 정보를 가져오는 api 호출
  Future<void> fetchJonrobusApi() async {
    try {
      final items = await getJongroBusArrivalList();
      items.forEachIndexed((index, element) {
        arrmsg1[index] = element.arrivals.first.message;
        arrmsg2[index] = element.arrivals.last.message;
      });
      arrmsg1.refresh();
      arrmsg2.refresh();
    } on FailedToGetJongroBusListException {
      // controller.jongro07BusMessage.value = "정보 없음 [4]";
      // print('error 2');
      return;
    } on NoJongroBusListException {
      // controller.jongro07BusMessage.value = "정보 없음 [3]";
      // print('error 1');
      return;
    }

    // 두번째 api 호출
    try {
      final list = await getJongroBusList();
      controller.fetchBusMap(list);
      int count = 0;

      flag.value = List.filled(19, 0);
      for (final bus in list) {
        count++;
        int index = stationNodeId.indexWhere((id) => id == bus.lastStationId);

        if (index != -1) {
          flag[index] = 1;
          busNum[index] = bus.busNumber.substring(2);
        }

        // 요거 flag 때문에 에러나는거였다

        // int index = stationNodeId.indexWhere((id) => id == lastStnId);
        // if (index == -1) {
        //   flag[index] = 0;
        // } else if (stopFlag == "1") {
        //   flag[index] = 2;
        // } else if (index != -1) {
        //   flag[index] = 1;
        // } else {
        //   flag[index] = 0;
        // }

        activeBusCount.value = count;
      }
      print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=');

      print(flag);
      print('=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=');
    } on Exception {
      controller.fetchBusMap([]);
      // 기타 예외 처리
      // controller.jongro07BusMessage.value = "정보 없음 [2]";
      return;
    }
  }
}
