import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skkumap/app/data/model/bus_data_model.dart';
import 'package:skkumap/app/data/repository/bus_data_repository.dart';
import 'dart:async';

class BusDataController extends GetxController {
  final BusDataRepository repository;
  final currentTime = ''.obs;
  final activeBusCount = 0.obs;
  var busDataList = <BusData>[].obs;
  var refreshTime = 15.obs;

  Timer? updateTimer;

  BusDataController({required this.repository});

  String timeDifference(String eventDate) {
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime eventDateTime;
    try {
      eventDateTime = format.parse(eventDate);
    } catch (e) {
      print("Error parsing date: $e");
      return "Invalid Date";
    }

    // print('Now: ${DateTime.now()}');
    // print('Event date: $eventDateTime');
    final duration = DateTime.now().difference(eventDateTime);

    if (duration.inSeconds < 10) {
      return '도착 혹은 출발';
    }
    // else if (duration.inDays > 1) {
    //   return '하루 이상 전 도착!';
    // }
    else {
      return '${duration.inMinutes}분 ${duration.inSeconds % 60}초 전 정류장 떠남';
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchBusData();
    startUpdateTimer();
  }

  @override
  void onClose() {
    updateTimer?.cancel();
    super.onClose();
  }

  void startUpdateTimer() {
    updateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (refreshTime.value > 0) {
        refreshTime.value--;
      } else {
        refreshTime.value = 15;
        refreshData();
      }
    });
  }

  void refreshData() {
    updateTimer?.cancel();
    fetchBusData();
    updateTime();
    refreshTime.value = 15;
    startUpdateTimer();
  }

  void fetchBusData() async {
    try {
      var data = await repository.getBusData();
      busDataList.assignAll(data);
      updateActiveBusCount();
    } catch (e) {
      print('Failed to fetch bus data: $e');
    }
  }

  void updateTime() {
    final format = DateFormat.jm(); // Output: hh:mm AM/PM
    currentTime.value = format.format(DateTime.now());
  }

  void updateActiveBusCount() {
    activeBusCount.value = getActiveBusCount(busDataList);
  }

  int getActiveBusCount(List<BusData> busDataList) {
    return busDataList.where((bus) => bus.carNumber.isNotEmpty).length;
  }
}
