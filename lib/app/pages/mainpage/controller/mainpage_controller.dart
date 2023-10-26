import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'dart:io' show Platform;

import 'package:get/get.dart';

import 'dart:async';

import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);
AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

const double hewa1Lat = 37.583427;
const double hewa1Lon = 127.001850;

RxBool loadingdone = false.obs;

late var seoulMarker;
late var markerinfo;

class mainpageController extends GetxController {
  RxString name = '로그인해주세요'.obs;
  RxString subname = ''.obs;
  late NOverlayImage iconImage;

  @override
  void onInit() {
    super.onInit();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   fetchSecureStorage();
    // }); // 의도한대로 작동 안해서 그냥 사이드바 열때 securestorage fetch하도록 함
    fetchIconImage();
    fetchSecureStorage();
  }

  Future<void> fetchSecureStorage() async {
    name.value =
        await storage.read(key: 'local_name', iOptions: options) ?? '로그인해주세요';
    subname.value =
        await storage.read(key: 'local_branchGroup', iOptions: options) ?? '';
  }

  Future<void> fetchIconImage() async {
    // iconImage = await createIconImage();
    // update(); // if you're using GetBuilder, otherwise not needed for Obx
    seoulMarker = NMarker(
      id: 'seoul_marker',
      position: const NLatLng(hewa1Lat, hewa1Lon),

      // icon: iconImage,
      // icon: controller.iconImage,
    );

    // markerinfo =
    //     NInfoWindow.onMarker(id: 'seoul_marker', text: '인사캠 셔틀 \\ 종로07');
    // seoulMarker.openInfoWindow(markerinfo);
    loadingdone.value = true;
  }

  Future<NOverlayImage> createIconImage() async {
    // Use the context from the nearest ancestor GetMaterialApp or GetBuilder
    final context = Get.context!;
    return await NOverlayImage.fromWidget(
      widget: const FlutterLogo(),
      size: const Size(24, 24),
      context: context,
    );
  }
}
