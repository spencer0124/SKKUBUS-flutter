import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:skkumap/app/pages/KingoLogin/controller/KingoLogin_controller.dart';

import 'package:skkumap/app/pages/LocalAuth/controller/localauth_controller.dart';

import 'package:skkumap/app/pages/bus_inja_detail/controller/bus_inja_detail_controller.dart';
import 'package:skkumap/app/pages/mainpage/controller/mainpage_controller.dart';
import 'package:skkumap/app/pages/bus_jonro_main/controller/bus_jonro_main_controller.dart';
import 'package:skkumap/app/pages/userchat/controller/userchat_controller.dart';
import 'dart:ui';
import 'dart:async';
import 'package:get/get.dart';

import 'package:skkumap/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'languages.dart';

import 'package:skkumap/app/data/repository/bus_data_repository.dart';
import 'package:skkumap/app/data/provider/but_data_provider.dart';
import 'package:skkumap/app/pages/bus_seoul_main/controller/bus_seoul_main_controller.dart';
import 'package:skkumap/app/routes/app_routes.dart';
import 'package:skkumap/app/pages/bus_inja_main/controller/bus_inja_main_controller.dart';
import 'package:skkumap/app/pages/bus_seoul_detail/controller/bus_seoul_detail_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  try {
    await FirebaseMessaging.instance.subscribeToTopic("necessaryupdate");
  } catch (e) {
    print(e);
  }

  registerDependencies();
  await initFirebase();
  await initMobileAds();
  await initEnvironmentVariables();
  await initNaverMapSdk();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: AppRoutes.routes,
        initialRoute: '/mainpage',
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

Future<void> initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (!kDebugMode) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
}

Future<void> initMobileAds() async {
  await MobileAds.instance.initialize();
}

Future<void> initEnvironmentVariables() async {
  await dotenv.load(fileName: ".env");
}

Future<void> initNaverMapSdk() async {
  await NaverMapSdk.instance.initialize(clientId: dotenv.env['naverClientId']!);
}

void registerDependencies() {
  Get.lazyPut(() => BusDataProvider());
  Get.lazyPut(() => BusDataRepository(dataProvider: Get.find()));
  Get.lazyPut(() => BusDataController(repository: Get.find()));
  Get.lazyPut(() => SeoulMainLifeCycle());

  Get.lazyPut(() => SeoulDetailController());
  Get.lazyPut(() => SeoulDetailLifeCycle());

  Get.lazyPut(() => InjaMainController());
  Get.lazyPut(() => InjaMainLifeCycle());

  Get.lazyPut(() => InjaDetailController());
  Get.lazyPut(() => InjaDetailLifeCycle());

// Get.lazyPut(() => KingoInfoController());
// Get.lazyPut(() => KingoInfoLifeCycle());

  Get.lazyPut(() => KingoLoginController());
  Get.lazyPut(() => KingoLoginLifeCycle());

  Get.lazyPut(() => LocalAuthController());
  Get.lazyPut(() => LocalAuthLifeCycle());

  Get.lazyPut(() => MainpageController());
  Get.lazyPut(() => MainpageLifeCycle());

  Get.lazyPut(() => UserChatController());
  Get.lazyPut(() => UserChatLifeCycle());

  Get.lazyPut(() => JonroMainController());
  Get.lazyPut(() => JonroMainLifeCycle());
}
