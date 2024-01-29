import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

import 'package:skkumap/admob/ad_helper.dart';
import 'package:skkumap/app/model/bus_station_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:skkumap/app/model/hssc_buslocation.dart';

import 'package:skkumap/app/utils/api_fetch/hssc_buslocation.dart';

import 'dart:async';

// life cycle
class SeoulMainLifeCycle extends GetxController with WidgetsBindingObserver {
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
      // 화면 다시 돌아왔을때 할 일 정해주기
    }
  }
}

// main controller
class BusDataController extends GetxController {
  Timer? _timer;

  BannerAd? _bannerAd;
  BannerAd? get bannerAd => _bannerAd;
  RxBool isBannerAdLoaded = false.obs;

  @override
  void onInit() async {
    super.onInit();
    _initializeBannerAd();
    fetchBusStations();
    fetchHsscBusLocation();
    _timer = Timer.periodic(
        const Duration(seconds: 10), (Timer t) => fetchHsscBusLocation());
  }

  void _initializeBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _bannerAd = ad as BannerAd;
          update(); // Call update to refresh UI if needed
          isBannerAdLoaded.value = true;
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
          isBannerAdLoaded.value = false;
        },
      ),
    )..load();
  }

  var busStations = <BusStation>[].obs;
  var activeBusCount = 1.obs;
  var loadingdone = false.obs;

  void fetchBusStations() async {
    try {
      final response = await http.get(Uri.parse(dotenv.env['hsscListDev']!));

      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body);
        busStations.value = List<BusStation>.from(
            jsonResponse.map((model) => BusStation.fromJson(model)));
      } else {
        // Handle error
      }
    } finally {
      // isLoading.value = false;
      loadingdone.value = true;
    }
  }

  var hsscBusLocations = Rx<List<HSSCBusLocation>>([]);
  Future<void> fetchHsscBusLocation() async {
    try {
      hsscBusLocations.value = await fetchHSSCBusLocation();
      // print("===");
      // print('hsscBusLocations.value: ${hsscBusLocations.value}');
      // print("===");
    } catch (e) {
      print("---");
      print(e);
      print("---");
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    _bannerAd?.dispose();
    super.onClose();
  }
}
