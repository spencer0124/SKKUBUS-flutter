import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'dart:io' show Platform;

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
import 'package:permission_handler/permission_handler.dart';

import 'dart:io' show Platform;

import 'package:skkumap/app/utils/return_platform.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter_naver_map/flutter_naver_map.dart';

const double hewa1Lat = 37.583427;
const double hewa1Lon = 127.001850;

RxBool loadingdone = false.obs;

late var seoulMarker;
late var markerinfo;

class mainpageController extends GetxController {
  late NOverlayImage iconImage;

  @override
  void onInit() {
    super.onInit();
    fetchIconImage();
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

    markerinfo =
        NInfoWindow.onMarker(id: 'seoul_marker', text: '인사캠 셔틀 \\ 종로07');
    seoulMarker.openInfoWindow(markerinfo);
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
