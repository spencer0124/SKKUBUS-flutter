import 'package:get/get.dart';
import 'package:skkumap/app/data/model/bus_data_detail_model.dart';
import 'package:skkumap/app/data/repository/bus_data_detail_repository.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:skkumap/admob/ad_helper.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

class BusDetailController extends GetxController {
  final BusDetailRepository repository;
  var busDetail = BusDetail().obs;
  var phoneNumber = '027601073'.obs;
  var adLoad = true.obs;
  var isLoading = false.obs;

  BannerAd? _bannerAd;
  BannerAd? get bannerAd => _bannerAd;
  RxBool isAdLoaded = false.obs;

  void setPhoneNumber(String number) {
    phoneNumber.value = number;
  }

  BusDetailController({required this.repository});

  @override
  void onInit() async {
    try {
      await FirebaseAnalytics.instance
          .setCurrentScreen(screenName: 'bus_data_detail_screen');
    } catch (e) {}
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

    fetchBusDetail();
  }

  @override
  void onClose() {
    _bannerAd?.dispose();

    super.onClose();
  }

  void fetchBusDetail() async {
    try {
      var info = await repository.getBusDetail();
      busDetail.value = info;
      isLoading.value = true;
    } catch (e) {
      print('Error fetching data: $e');
      isLoading.value = false;
    }
  }
}
