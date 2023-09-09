import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';

String? routeToNavigate;

@pragma('vm:entry-point')
Future<void> notificationResponseHandler(NotificationResponse response) async {
  routeToNavigate = response.payload;
}

class FlutterLocalNotification {
  FlutterLocalNotification._();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static init() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      Get.toNamed('/eskara');
    }, onDidReceiveBackgroundNotificationResponse: notificationResponseHandler);
  }

  // notificationDetails() {
  //   return const NotificationDetails(
  //       android: AndroidNotificationDetails('channelId', 'channelName',
  //           importance: Importance.max),
  //       iOS: DarwinNotificationDetails());
  // }

  static NotificationDetails notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('skkubus', 'skkubus',
            channelDescription: 'skkubus', importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return flutterLocalNotificationsPlugin
        .show(id, title, body, notificationDetails(), payload: '/eskara');
  }

  static Future<void> scheduleNotification1() async {
    final scheduledDate =
        tz.TZDateTime(tz.getLocation('Asia/Seoul'), 2023, 9, 13, 08, 00, 02);
    final currentDate = tz.TZDateTime.now(tz.getLocation('Asia/Seoul'));

    if (scheduledDate.isAfter(currentDate)) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          0, // Notification ID
          'ESKARA 전야제 인자셔틀 정보', // Notification title
          '스꾸버스 앱 상단의 \'ESKARA 인자셔틀\' 버튼을 클릭하면 변경된 인자셔틀 탑승시간, 위치 정보를 확인할 수 있어요', // Notification body
          scheduledDate, // Date and time
          notificationDetails(),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: '/eskara');
    }
  }

  static Future<void> scheduleNotification2() async {
    final scheduledDate =
        tz.TZDateTime(tz.getLocation('Asia/Seoul'), 2023, 9, 14, 08, 00, 02);
    final currentDate = tz.TZDateTime.now(tz.getLocation('Asia/Seoul'));

    if (scheduledDate.isAfter(currentDate)) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        1, // Notification ID
        'ESKARA 인자셔틀 정보', // Notification title
        '스꾸버스 앱 상단의 \'ESKARA 인자셔틀\' 버튼을 클릭하면 변경된 인자셔틀 탑승시간, 위치 정보를 확인할 수 있어요', // Notification body
        scheduledDate, // Date and time
        notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  static Future<void> scheduleNotification3() async {
    final scheduledDate =
        tz.TZDateTime(tz.getLocation('Asia/Seoul'), 2023, 9, 10, 03, 10, 02);
    final currentDate = tz.TZDateTime.now(tz.getLocation('Asia/Seoul'));

    if (scheduledDate.isAfter(currentDate)) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        2, // Notification ID
        'ESKARA 인자셔틀 정보', // Notification title
        '스꾸버스 앱 상단의 \'ESKARA 인자셔틀\' 버튼을 클릭하면 변경된 인자셔틀 탑승시간, 위치 정보를 확인할 수 있어요', // Notification body
        scheduledDate, // Date and time
        notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  static Future<void> scheduleNotification4() async {
    final scheduledDate =
        tz.TZDateTime(tz.getLocation('Asia/Seoul'), 2023, 9, 10, 03, 15, 02);
    final currentDate = tz.TZDateTime.now(tz.getLocation('Asia/Seoul'));

    if (scheduledDate.isAfter(currentDate)) {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        3, // Notification ID
        'ESKARA 인자셔틀 정보', // Notification title
        '스꾸버스 앱 상단의 \'ESKARA 인자셔틀\' 버튼을 클릭하면 변경된 인자셔틀 탑승시간, 위치 정보를 확인할 수 있어요', // Notification body
        scheduledDate, // Date and time
        notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  // static requestNotificationPermission() {
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //         alert: true,
  //         badge: true,
  //         sound: true,
  //       );
  // }

  // static Future<void> showNotification() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('skkubus', 'skkubus',
  //           channelDescription: 'skkubus alert',
  //           importance: Importance.max,
  //           priority: Priority.max,
  //           showWhen: false);

  //   const NotificationDetails notificationDetails = NotificationDetails(
  //       android: androidNotificationDetails,
  //       iOS: DarwinNotificationDetails(badgeNumber: 1));

  //   await flutterLocalNotificationsPlugin.show(
  //       0, '버스가 전 정류장 ()에 도착했어요', '승차를 준비하세요!', notificationDetails);
  // }
}
