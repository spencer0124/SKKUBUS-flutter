import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:skkumap/firebase_options.dart';

import 'package:get/get.dart';

import 'package:skkumap/app/data/repository/bus_data_repository.dart';
import 'package:skkumap/app/data/provider/but_data_provider.dart';
import 'package:skkumap/app/controller/bus_data_controller.dart';
import 'package:skkumap/app/routes/app_routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:skkumap/app/controller/bus_data_detail_controller.dart';
import 'package:skkumap/app/data/provider/bus_data_detail_provider.dart';
import 'package:skkumap/app/data/repository/bus_data_detail_repository.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:ui';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:skkumap/notification_station.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'package:skkumap/app/controller/ESKARA_controller.dart';

Future<void> main() async {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  MobileAds.instance.initialize();

  await dotenv.load(fileName: ".env");

  // Registering the classes in GetX
  Get.put(BusDataProvider());
  Get.put(BusDataRepository(dataProvider: Get.find()));
  Get.put(BusDataController(repository: Get.find()));
  Get.put(LifeCycleGetx());
  Get.put(LifeCycleGetx2());

  // Register BusDetail dependencies
  Get.put(BusDetailDataProvider());
  Get.put(BusDetailRepository(dataProvider: Get.find()));
  Get.put(BusDetailController(repository: Get.find()));

  Get.put(ESKARAController());

  // FlutterLocalNotification.requestNotificationPermission();
  FlutterLocalNotification.init();
  await FlutterLocalNotification.scheduleNotification1();
  await FlutterLocalNotification.scheduleNotification2();

  await NaverMapSdk.instance.initialize(clientId: dotenv.env['naverClientId']!);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: AppRoutes.routes,
        initialRoute: routeToNavigate ?? '/',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
      ),
    );
  }
}
