import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:skkumap/app/pages/KingoLogin/controller/KingoLogin_controller.dart';

import 'package:skkumap/app/pages/LocalAuth/controller/localauth_controller.dart';

import 'package:skkumap/app/pages/bus_inja_detail/controller/bus_inja_detail_controller.dart';
import 'package:skkumap/app/pages/LocalAuth/mainpage/controller/mainpage_controller.dart';
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
import 'package:skkumap/app/pages/bus_seoul_main/controller/bus_seoul_main_controller.dart';
import 'package:skkumap/app/routes/app_routes.dart';
import 'package:skkumap/app/pages/bus_inja_main/controller/bus_inja_main_controller.dart';
import 'package:skkumap/app/pages/bus_seoul_detail/controller/bus_seoul_detail_controller.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
// import 'package:skkumap/setting/securestorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

late FirebaseAuth auth;
late User user;
late final uid;
// late final campus;

const storage = FlutterSecureStorage();

late SharedPreferences prefs;
bool logindataSavedValue = false;
bool blockeduser = false;
bool unknownerror = false;
late String id, pw;

// 앱이 백그라운드에서 알림 수신했을때
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> initFirebaseMessaging() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // NotificationSettings settings =
  //     await FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  //   provisional: false,
  // );
  // print('User granted permission: ${settings.authorizationStatus}');
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void setupFirebaseMessagingListeners() {
  // 앱이 foreground 상태일 때
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print(message);
    print("Foreground message received: ${message.notification!.body!}");

    if (await canLaunchUrl(Uri.parse('http://skkubus-app.kro.kr'))) {
      await launchUrl(Uri.parse('http://skkubus-app.kro.kr'));
    }

    Get.toNamed('/userchat');

    // if (message.data['type'] == 'update') {
    //   Get.toNamed('/userchat');
    // }

    // Handle the foreground notification or update the UI if necessary
  });

  // 앱이 백그라운드에서 열리는 경우 행동 - 완료
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print(message);
    if (await canLaunchUrl(Uri.parse('http://skkubus-app.kro.kr'))) {
      await launchUrl(Uri.parse('http://skkubus-app.kro.kr'));
    }

    Get.toNamed('/userchat');
    // if (message.data['type'] == 'update') {
    //   if (await canLaunchUrl(Uri.parse('http://skkubus-app.kro.kr'))) {
    //     await launchUrl(Uri.parse('http://skkubus-app.kro.kr'));
    //   }
    // }
    print("Message clicked: ${message.notification!.body!}");
    // Handle the notification or navigate to a certain screen
  });

  // 앱이 종료된 상태에서 열리는 경우 행동 - 완료
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) async {
    if (message != null) {
      print(message);
      print(
          "App opened by tapping on the notification: ${message.notification!.body!}");
      if (await canLaunchUrl(Uri.parse('http://skkubus-app.kro.kr'))) {
        await launchUrl(Uri.parse('http://skkubus-app.kro.kr'));
      }

      Get.toNamed('/userchat');
      // if (message.data['type'] == 'update') {
      //   if (await canLaunchUrl(Uri.parse('http://skkubus-app.kro.kr'))) {
      //     await launchUrl(Uri.parse('http://skkubus-app.kro.kr'));
      //   }
      // }
      // Handle the notification caused by tapping on it in a terminated state
    }
  });
}

////
Future<void> main() async {
  // Get.put(StorageController());

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.subscribeToTopic("necessaryupdate");

  registerDependencies();

  getMyDeviceToken();

  await initTimeZones();
  await initSharedPreferences();
  await initFirebase();
  await initMobileAds();
  await initEnvironmentVariables();
  // await initNotifications();

  initLocalNotification();
  await initNaverMapSdk();

  await checkLocalDataSaved();

  await initLogin();

  await initFirebaseMessaging();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

///
///

void initLocalNotification() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
          'high_importance_channel', 'high_importance_notification',
          importance: Importance.max));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final bool newalertdone = prefs.getBool('newalertdone') ?? false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      print(uid);
      print('online -> resumed');

      var campus = ((await storage.read(key: 'local_branchGroup')) == '자연과학캠퍼스')
          ? 'live_inja_suwon'
          : 'typeA_hewa';
      final url = Uri.parse(
        dotenv.env['UpdateLiveAccessUrl']!,
      );

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "uid": uid,
            "stationtype": campus,
            "accesstoken": dotenv.env['UpdateLiveAccessToken']!
          },
        ),
      );

      print(response.body);
    }
    //TODO: set status to online here in firestore
    else {
      var campus = ((await storage.read(key: 'local_branchGroup')) == '자연과학캠퍼스')
          ? 'live_inja_suwon'
          : 'typeA_hewa';
      final url = Uri.parse(
        dotenv.env['DeleteLiveAccessUrl']!,
      );

      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "uid": uid,
            "stationtype": campus,
            "accesstoken": dotenv.env['UpdateLiveAccessToken']!
          },
        ),
      );

      print(response.body);
    }
    //TODO: set status to offline here in firestore
  }

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
  if ((await storage.read(key: 'local_dataSaved')) == 'true') {
    id = '${(await storage.read(key: 'local_id'))!}@g.skku.edu';
    pw = (await storage.read(key: 'local_firebasepw'))!;
    print('id: $id');
    print('pw: $pw');
    logindataSavedValue = true;
  }

  print('---123');
  print((await storage.read(key: 'local_dataSaved')));
  print(logindataSavedValue);
  print('---123');
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
  if (!kDebugMode) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

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
  Get.put(BusDataProvider());
  Get.put(BusDataRepository(dataProvider: Get.find()));
  Get.put(BusDataController(repository: Get.find()));
  Get.put(SeoulMainLifeCycle());

  Get.put(SeoulDetailController());
  Get.put(SeoulDetailLifeCycle());

  Get.put(InjaMainController());
  Get.put(InjaMainLifeCycle());

  Get.put(InjaDetailController());
  Get.put(InjaDetailLifeCycle());

  // Get.put(KingoInfoController());
  // Get.put(KingoInfoLifeCycle());

  Get.put(KingoLoginController());
  Get.put(KingoLoginLifeCycle());

  Get.put(LocalAuthController());
  Get.put(LocalAuthLifeCycle());

  Get.put(MainpageController());
  Get.put(MainpageLifeCycle());

  Get.put(UserChatController());
  Get.put(UserChatLifeCycle());
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
      print(e.toString());
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
      print(e.toString());
      print('initLogin 실패 / signInAnonymously / unknownerror');
    }
  }

  auth = FirebaseAuth.instance;
  user = auth.currentUser!;
  uid = user.uid;
}

///////////////////

void getMyDeviceToken() async {
  final token = await FirebaseMessaging.instance.getToken();
  print('--');
  print("내 디바이스 토큰: $token");
  print('--');
}
