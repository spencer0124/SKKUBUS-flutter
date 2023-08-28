import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skkumap/app/data/model/bus_data_model.dart';
import 'package:skkumap/app/data/repository/bus_data_repository.dart';
import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import 'package:skkumap/admob/ad_helper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'dart:io' show Platform;

class LifeCycleGetx extends GetxController with WidgetsBindingObserver {
  BusDataController busDataController = Get.find<BusDataController>();

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
      if (busDataController.refreshTime.value > 1 &&
          busDataController.preventAnimation.value == false) {
        busDataController.refreshData();
      }
    }
  }
}

class BusDataController extends GetxController
    with SingleGetTickerProviderMixin {
  RxBool waitAdFail = false.obs;
  RxBool preventAnimation = false.obs;
  late String platform;

  @override
  void onInit() {
    // createDynamicLink();
    super.onInit();

    if (Platform.isAndroid) {
      platform = 'Android';
    } else if (Platform.isIOS) {
      platform = 'IOS';
    } else {
      platform = 'unknown';
    }

    Future.delayed(const Duration(milliseconds: 1400), () {
      waitAdFail.value = true;
      FirebaseAnalytics.instance
          .logEvent(name: 'alternative_ad_showed', parameters: {
        'platform': platform,
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _bannerAd = ad as BannerAd;
          isAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    )..load();

    updateTime();
    fetchBusData();
    startUpdateTimer();
  }

  BannerAd? _bannerAd;
  BannerAd? get bannerAd => _bannerAd;
  RxBool isAdLoaded = false.obs;
  AnimationController? _animationController;
  AnimationController? get animationController => _animationController;

  final BusDataRepository repository;
  final currentTime = ''.obs;

  // final activeBusCount = 0.obs;
  final activeBusCount = Rx<int?>(null);
  var adLoad = false.obs;
  var busDataList = <BusData>[].obs;
  var refreshTime = 5.obs;

  final stations = [
    '정차소(인문.농구장)',
    '학생회관(인문)',
    '정문(인문-하교)',
    '혜화로터리(하차지점)',
    '혜화역U턴지점',
    '혜화역(승차장)',
    '혜화로터리(경유)',
    '맥도날드 건너편',
    '정문(인문-등교)',
    '600주년 기념관'
  ];
  var logger = Logger();

  RxBool loadingAnimation = false.obs;

  Timer? updateTimer;

  BusDataController({required this.repository});

  String getNextStation(String currentStation) {
    int currentIndex = stations.indexOf(currentStation);
    if (currentIndex != -1 && currentIndex < stations.length - 1) {
      return stations[currentIndex + 1]; // Returns the next station
    } else if (currentIndex == stations.length - 1) {
      return stations[0]; // If it's the last station, return the first one
    } else {
      return 'null'; // If the currentStation is not found in the list
    }
  }

  String getStationMessage(int index) {
    var currentStation = busDataList[index].stationName;
    var currentIndex = stations.indexOf(currentStation);

    for (var i = currentIndex - 1; i >= 0; i--) {
      if (busDataList[i].carNumber.isNotEmpty) {
        return '${currentIndex - i}개 정거장 남음';
      }
    }

    return '도착 정보 없음';
  }

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

    if (duration.inSeconds < 15) {
      return '도착 혹은 출발';
    } else if (duration.inDays > 1) {
      return '하루 이상 전 정류장 떠남';
    } else {
      return '${duration.inMinutes}분 ${duration.inSeconds % 60}초 전 정류장 떠남';
    }
  }

  String timeDifference2(String eventDate) {
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

    return '${duration.inMinutes}분 ${duration.inSeconds % 60}초';
  }

  int timeDifference3(String eventDate) {
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime eventDateTime;
    try {
      eventDateTime = format.parse(eventDate);
    } catch (e) {
      print("Error parsing date: $e");
      return 0;
    }

    // print('Now: ${DateTime.now()}');
    // print('Event date: $eventDateTime');
    final duration = DateTime.now().difference(eventDateTime);

    return duration.inSeconds;
  }

  @override
  void onClose() {
    _bannerAd?.dispose();
    updateTimer?.cancel();
    super.onClose();
  }

  void startUpdateTimer() {
    updateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (refreshTime.value > 0) {
        refreshTime.value--;
      } else {
        refreshData();
        // Future.delayed(const Duration(milliseconds: 1000), () {});
      }
    });
  }

  void refreshData() {
    updateTimer?.cancel();
    fetchBusData();
    updateTime();

    _animationController?.reset();
    _animationController?.forward();

    Future.delayed(const Duration(milliseconds: 1000), () {
      refreshTime.value = 5;
      startUpdateTimer();
    });
  }

  Future<void> waitanimation() async {
    await Future.delayed(const Duration(seconds: 2));
    loadingAnimation.value = false;
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
