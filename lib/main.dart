import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import 'dart:async';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:skkumap/firebase_options.dart';
import 'package:skkumap/notification_station.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'languages.dart';

import 'package:skkumap/app/data/repository/bus_data_repository.dart';
import 'package:skkumap/app/data/provider/but_data_provider.dart';
import 'package:skkumap/app/pages/bus_seoul_main/controller/bus_data_controller.dart';
import 'package:skkumap/app/routes/app_routes.dart';
import 'package:skkumap/app/pages/bus_inja_detail/controller/bus_inja_detail_controller.dart';
import 'package:skkumap/app/pages/bus_seoul_detail/controller/bus_data_detail_controller.dart';
import 'package:skkumap/app/data/provider/bus_data_detail_provider.dart';
import 'package:skkumap/app/data/repository/bus_data_detail_repository.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

late SharedPreferences prefs;

////
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );

  await initTimeZones();
  await initSharedPreferences();
  await initFirebase();
  await initMobileAds();
  await initEnvironmentVariables();
  // await initNotifications(); // ESKARA 알림 설정
  await initNaverMapSdk();
  registerDependencies();

  runApp(MyApp());
}

///

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final bool newalertdone = prefs.getBool('newalertdone') ?? false;

  // 새로운 기능 있을때 new_alert 페이지를 거치게 해서 보여주고 싶으면 주석 해제하고 설정하면 된다
  String determineInitialRoute() {
    String? routeFromPrefs = prefs.getString('routeToNavigate');
    if (routeFromPrefs != null) {
      prefs.remove('routeToNavigate');
      return routeFromPrefs;
    }
    // else if (!newalertdone) {
    //   return '/newalert';
    // }
    else {
      return '/';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: AppRoutes.routes,
        initialRoute: determineInitialRoute(),
        translations: Languages(),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'US'),
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
      ),
    );
  }
}
////

Future<void> initTimeZones() async {
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
}

Future<void> initSharedPreferences() async {
  prefs = await SharedPreferences.getInstance();
  SharedPreferences.getInstance().then((value) => prefs = value);
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

Future<void> initMobileAds() async {
  await MobileAds.instance.initialize();
}

Future<void> initEnvironmentVariables() async {
  await dotenv.load(fileName: ".env");
}

Future<void> initNotifications() async {
  FlutterLocalNotification.init();
  await FlutterLocalNotification.scheduleNotification1();
  await FlutterLocalNotification.scheduleNotification2();
  await FlutterLocalNotification.scheduleNotification3();
  await FlutterLocalNotification.scheduleNotification4();
}

Future<void> initNaverMapSdk() async {
  await NaverMapSdk.instance.initialize(clientId: dotenv.env['naverClientId']!);
}

void registerDependencies() {
  // bus_seoul_main
  Get.put(BusDataProvider());
  Get.put(BusDataRepository(dataProvider: Get.find()));
  Get.put(BusDataController(repository: Get.find()));
  Get.put(LifeCycleGetx());

  // bus_seoul_detail
  Get.put(BusDetailDataProvider());
  Get.put(BusDetailRepository(dataProvider: Get.find()));
  Get.put(BusDetailController(repository: Get.find()));

  // bus_inja_detail
  Get.put(ESKARAController());
  Get.put(LifeCycleGetx2());
}

///////////////////


