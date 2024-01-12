import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;

import 'package:skkumap/admob/ad_helper.dart';
import 'package:skkumap/app/model/bus_station_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  BannerAd? _bannerAd;
  BannerAd? get bannerAd => _bannerAd;
  RxBool isBannerAdLoaded = false.obs;

  @override
  void onInit() async {
    super.onInit();
    _initializeBannerAd();
    fetchBusStations();
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
  var activeBusCount = 0.obs;
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

  @override
  void onClose() {
    _bannerAd?.dispose();
    super.onClose();
  }
}
