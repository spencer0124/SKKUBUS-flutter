import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class LifeCycleGetx2 extends GetxController with WidgetsBindingObserver {
  ESKARAController eSKARAController = Get.find<ESKARAController>();

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
      eSKARAController.determineNextBus();
    }
  }
}

class ESKARAController extends GetxController {
  // Define the available bus times
  final List<String> seoul_13_busTimes = [
    '07:00',
    '10:00',
    '12:00',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:30',
    '18:00',
    '19:00'
  ];

  final List<String> seoul_14_busTimes = [
    '07:00',
    '10:00',
    '10:15',
    '10:30',
    '10:45',
    '11:00',
    '11:15',
    '11:30',
    '11:45',
    '12:00',
    '12:15',
    '12:30',
    '12:45',
    '13:00',
    '13:15',
    '13:30',
    '15:00',
    '16:30',
    '18:00',
    '19:00'
  ];

  final List<String> suwon_13_busTimes = [
    '07:00',
    '10:30',
    '12:00',
    '13:30',
    '15:00',
    '16:30',
    '18:00',
    '23:20',
    '23:30',
    '23:40',
  ];

  final List<String> suwon_14_busTimes = [
    '07:00',
    '10:30',
    '12:00',
    '13:30',
    '15:00',
    '16:30',
    '18:00',
    '23:20',
    '23:30',
    '23:40',
  ];

  // This variable will hold the next available bus time
  var seoul_13_nextBusTime = ''.obs;
  var seoul_14_nextBusTime = ''.obs;
  var suwon_13_nextBusTime = ''.obs;
  var suwon_14_nextBusTime = ''.obs;

  @override
  void onInit() {
    super.onInit();
    determineNextBus();
  }

  void determineNextBus() {
    DateTime now = DateTime.now().toLocal();
    String formattedDate = DateFormat('M/d').format(now);
    String formattedTime = DateFormat('HH:mm').format(now);

    if (formattedDate == '9/9') {
      String nextBus = seoul_13_busTimes.firstWhere(
        (busTime) => busTime.compareTo(formattedTime) > 0,
        orElse: () => 'No more buses available today',
      );
      seoul_13_nextBusTime.value = nextBus;
    }
    // 테스트 말고 실제로 구현할때는 else-if로 변경하기!! To-Do
    if (formattedDate == '9/9') {
      String nextBus = seoul_14_busTimes.firstWhere(
        (busTime) => busTime.compareTo(formattedTime) > 0,
        orElse: () => 'No more buses available today',
      );
      seoul_14_nextBusTime.value = nextBus;
    }

    if (formattedDate == '9/9') {
      String nextBus = suwon_13_busTimes.firstWhere(
        (busTime) => busTime.compareTo(formattedTime) > 0,
        orElse: () => 'No more buses available today',
      );
      suwon_13_nextBusTime.value = nextBus;
    }

    if (formattedDate == '9/9') {
      String nextBus = suwon_14_busTimes.firstWhere(
        (busTime) => busTime.compareTo(formattedTime) > 0,
        orElse: () => 'No more buses available today',
      );
      suwon_14_nextBusTime.value = nextBus;
    }
  }
}
