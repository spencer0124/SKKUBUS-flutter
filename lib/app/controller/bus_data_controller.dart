import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skkumap/app/data/model/bus_data_model.dart';
import 'package:skkumap/app/data/repository/bus_data_repository.dart';
import 'dart:async';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import 'package:skkumap/admob/ad_helper.dart';

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
      busDataController.refreshData();
      // Get.dialog(
      //   AlertDialog(
      //     title: const Text('Welcome back!'),
      //     content: const Text('The app is resumed.'),
      //     actions: <Widget>[
      //       TextButton(
      //         child: const Text('OK'),
      //         onPressed: () {
      //           Get.back();
      //         },
      //       ),
      //     ],
      //   ),
      // );
    }
  }
}

class BusDataController extends GetxController {
  BannerAd? _bannerAd;
  BannerAd? get bannerAd => _bannerAd;
  RxBool isAdLoaded = false.obs;

  final BusDataRepository repository;
  final currentTime = ''.obs;

  // final activeBusCount = 0.obs;
  final activeBusCount = Rx<int?>(null);
  var adLoad = false.obs;
  var busDataList = <BusData>[].obs;
  var refreshTime = 15.obs;

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

  // Future<void> createDynamicLink() async {
  //   String _yourDomain = "skkubus";
  //   String _defaultLink = 'https://www.naver.com';

  //   DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
  //     uriPrefix: "https://$_yourDomain.page.link",
  //     link: Uri.parse("https://$_yourDomain.page.link/app"),
  //     androidParameters: const AndroidParameters(
  //       packageName: 'com.zoyoong.skkubus',
  //       minimumVersion: 0,
  //     ),
  //     iosParameters: const IOSParameters(
  //       bundleId: 'com.example.skkumap',
  //       minimumVersion: '0',
  //     ),
  //     navigationInfoParameters: const NavigationInfoParameters(
  //       forcedRedirectEnabled: true,
  //     ),
  //     longDynamicLink: Uri.parse(
  //       'https://skkubus.page.link/?link=http%3a%2f%2fskkubus%2fmain&apn=com.zoyoong.skkubus[&amv=0][&afl=http%3a%2f%2fskkubus.kro.kr][&ofl=https%3A%2F%2Fwww.naver.com]',
  //     ),
  //   );

  //   ShortDynamicLink dynamicLink =
  //       await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

  //   String url = dynamicLink.shortUrl.toString();
  //   logger.e(url);
  // }

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
  void onInit() {
    // createDynamicLink();
    super.onInit();

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
