import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skkumap/app/pages/KingoInfo/controller/kingoinfo_controller.dart';
import 'package:skkumap/app/pages/KingoInfo/ui/kingoinfo_view.dart';
import 'package:skkumap/app/pages/KingoLogin/controller/KingoLogin_controller.dart';
import 'package:skkumap/app/pages/KingoLogin/ui/KingoLogin_view.dart';
import 'package:skkumap/app/pages/LocalAuth/controller/localauth_controller.dart';
import 'package:skkumap/app/pages/LocalAuth/view/localauth_view.dart';
import 'package:skkumap/app/pages/bus_inja_detail/controller/bus_inja_detail_controller.dart';
import 'package:skkumap/app/pages/mainpage/controller/mainpage_controller.dart';
import 'package:skkumap/app/pages/userchat/controller/userchat_controller.dart';
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
import 'package:skkumap/app/pages/bus_inja_main/controller/bus_inja_main_controller.dart';
import 'package:skkumap/app/pages/bus_seoul_detail/controller/bus_data_detail_controller.dart';
import 'package:skkumap/app/data/provider/bus_data_detail_provider.dart';
import 'package:skkumap/app/data/repository/bus_data_detail_repository.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:skkumap/setting/securestorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

late SharedPreferences prefs;
bool logindataSavedValue = false;
bool blockeduser = false;
bool unknownerror = false;
String id = 'spencer0124@g.skku.edu', pw = '2023310021cilGN7';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> initFirebaseMessaging() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (Platform.isIOS) {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    print('User granted permission: ${settings.authorizationStatus}');
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

void setupFirebaseMessagingListeners() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(message);
    print("Foreground message received: ${message.notification!.body!}");
    // Handle the foreground notification or update the UI if necessary
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Message clicked: ${message.notification!.body!}");
    // Handle the notification or navigate to a certain screen
  });

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      print(
          "App opened by tapping on the notification: ${message.notification!.body!}");
      // Handle the notification caused by tapping on it in a terminated state
    }
  });
}

////
Future<void> main() async {
  Get.put(StorageController());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );

  registerDependencies();

  getMyDeviceToken();

  await initTimeZones();
  await initSharedPreferences();
  await initFirebase();
  await initMobileAds();
  await initEnvironmentVariables();
  // await initNotifications(); //
  await initNaverMapSdk();

  await checkLocalDataSaved();

  await initLogin();

  await initFirebaseMessaging();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

///

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final bool newalertdone = prefs.getBool('newalertdone') ?? false;

  // 새로운 기능 있을때 new_alert 페이지를 거치게 해서 보여주고 싶으면 주석 해제하고 설정하면 된다
  String determineInitialRoute() {
    String? routeFromPrefs = prefs.getString('routeToNavigate');

    if (unknownerror) {
      return '/userchat';
    } else if (blockeduser) {
      return '/injadetail';
    } else if (routeFromPrefs != null) {
      prefs.remove('routeToNavigate');
      return routeFromPrefs;
    }
    // else if (!newalertdone) {
    //   return '/newalert';
    // }
    else {
      return '/mainpage';
    }
  }

  @override
  Widget build(BuildContext context) {
    setupFirebaseMessagingListeners();

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
///
///

Future<void> checkLocalDataSaved() async {
  final StorageController storageController = Get.find<StorageController>();

  if ((await storageController.readValue('local_dataSaved')) == 'true') {
    logindataSavedValue = true;
  }

  print('---12');
  print(await storageController.readValue('local_dataSaved'));
  print(logindataSavedValue);
  print('---12');
}

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
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
}

Future<void> initMobileAds() async {
  await MobileAds.instance.initialize();
}

Future<void> initEnvironmentVariables() async {
  await dotenv.load(fileName: ".env");
}

Future<void> initNotifications() async {
  FlutterLocalNotification.init();
  // await FlutterLocalNotification.scheduleNotification1();
  // await FlutterLocalNotification.scheduleNotification2();
  // await FlutterLocalNotification.scheduleNotification3();
  // await FlutterLocalNotification.scheduleNotification4();
  // FlutterLocalNotification.init();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (Platform.isIOS) {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
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

  Get.put(BusDetailController());

  // bus_inja_detail
  Get.put(ESKARAController());
  Get.put(LifeCycleGetx2());

  Get.put(mainpageController());

  Get.put(UserChatController());

  Get.put(InjaDetailController());

  Get.put(KingoLoginController());

  // Get.put(KingoInfoController());

  // Get.put(LocalAuthController());
}

Future<void> initLogin() async {
  if (logindataSavedValue) {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: id,
        password: pw,
      );
      print('initLogin 성공 / logindataSavedValue');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        blockeduser = true;
        print('initLogin 실패 / logindataSavedValue / blockeduser');
      } else {
        unknownerror = true;
        print('initLogin 실패 / logindataSavedValue / unknownerror');
      }
    }
  } else {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      print('initLogin 성공 / signInAnonymously');
    } on FirebaseAuthException catch (e) {
      unknownerror = true;
      print(e);
      print('initLogin 실패 / signInAnonymously / unknownerror');
    }
  }
}

///////////////////

void getMyDeviceToken() async {
  final token = await FirebaseMessaging.instance.getToken();
  print('--');
  print("내 디바이스 토큰: $token");
  print('--');
}
