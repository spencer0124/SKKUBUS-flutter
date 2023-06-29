import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:skkumap/firebase_options.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart' show parse;
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:skkumap/app/data/repository/bus_data_repository.dart';
import 'package:skkumap/app/data/provider/but_data_provider.dart';
import 'package:skkumap/app/controller/bus_data_controller.dart';
import 'package:skkumap/app/routes/app_routes.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:skkumap/app/controller/bus_data_detail_controller.dart';
import 'package:skkumap/app/data/provider/bus_data_detail_provider.dart';
import 'package:skkumap/app/data/repository/bus_data_detail_repository.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  MobileAds.instance.initialize();

  await dotenv.load(fileName: ".env");

  // Registering the classes in GetX
  Get.put(BusDataProvider());
  Get.put(BusDataRepository(dataProvider: Get.find()));
  Get.put(BusDataController(repository: Get.find()));

  // Register BusDetail dependencies
  Get.put(BusDetailDataProvider());
  Get.put(BusDetailRepository(dataProvider: Get.find()));
  Get.put(BusDetailController(repository: Get.find()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes,
      initialRoute: '/',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  const Location(this.latitude, this.longitude);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentCampus = '위치권한 없음';
  final distanceToC1 = const Location(37.583284835081, 126.99793900637);
  final distanceToC2 = const Location(37.296391553347, 126.97755824522);

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  void requestLocationPermission() async {
    final status = await Permission.location.request();
    print(status);
    if (status == PermissionStatus.granted) {
      // Location permission granted
      _getCurrentLocation();
    } else if (status == PermissionStatus.denied) {
      requestLocationPermission();
    } else if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
      return;
    }
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    final distancetoc1Cal = _calculateDistance(position, distanceToC1);
    final distancetoc2Cal = _calculateDistance(position, distanceToC2);

    setState(() {
      if (distancetoc1Cal <= distancetoc2Cal) {
        print(distancetoc1Cal);
        print(distancetoc2Cal);
        print(position);
        currentCampus = '인문사회과학캠퍼스';
      } else {
        currentCampus = '자연과학캠퍼스';
      }
    });
  }

  double _calculateDistance(Position from, Location to) {
    return Geolocator.distanceBetween(
        from.latitude, from.longitude, to.latitude, to.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF245439),
        title: const Text('스꾸버스'),
        elevation: 0,
        actions: const [],
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.grey[500],
              height: 200,
              width: double.infinity,
              child: Center(
                child: SizedBox(
                  height: 500,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 48,
                      ),
                      const Text(
                        '현재 캠퍼스',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        currentCampus,
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              launchUrl(
                                Uri.parse('http://skkubus-info.kro.kr'),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(3.5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  Text(
                                    ' 정보',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              launchUrl(
                                Uri.parse('http://skkubus-support.kro.kr'),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(3.5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.language,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  Text(
                                    ' 언어 설정',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.grey[800],
              height: 10,
              width: double.infinity,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Screen4()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                minimumSize: const Size(double.infinity, 70),
                elevation: 0,
                side: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 14, right: 10),
                    child: const Icon(
                      Icons.bus_alert,
                      color: Colors.grey,
                    ),
                  ),
                  const Text(
                    '인사캠 셔틀 실시간 위치',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 0.2,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Screen5()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                minimumSize: const Size(double.infinity, 70),
                elevation: 0,
                side: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 14, right: 10),
                    child: const Icon(
                      Icons.timelapse_outlined,
                      color: Colors.grey,
                    ),
                  ),
                  const Text(
                    '인-자 셔틀 운행 시간표',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}

class VerticalLine extends StatelessWidget {
  final double height;
  final Color color;

  const VerticalLine({super.key, required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(0, height),
      painter: _VerticalLinePainter(color: color),
    );
  }
}

class _VerticalLinePainter extends CustomPainter {
  final Color color;

  _VerticalLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    final startX = size.width / 2;
    const startY = 0.0;
    final endX = size.width / 2;
    final endY = size.height;

    canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
  }

  @override
  bool shouldRepaint(_VerticalLinePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class Screen4 extends StatefulWidget {
  const Screen4({super.key});

  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  List<Map<String, String>> _dataList = [];
  bool _isDisposed = false; // add a flag to track disposal

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    while (!_isDisposed) {
      // check the flag before continuing the loop
      const url =
          'https://www.skku.edu/skku/popup/shuttlebus_popup.do?srKey=2009';
      final response = await http.get(Uri.parse(url));
      final document = parse(response.body);

      final List<Map<String, String>> dataList = [];

      final activeLis = document.querySelectorAll('li.active');
      for (final li in activeLis) {
        final Map<String, String> data = {
          'text': li.text.trim(),
          'data-carnumber': li.attributes['data-carnumber'] ?? '',
          'data-eventdate': li.attributes['data-eventdate'] ?? '',
        };
        dataList.add(data);
      }

      if (!_isDisposed) {
        // check the flag before calling setState
        setState(() {
          _dataList = dataList;
        });
      }

      // 5초 동안 대기
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  @override
  void dispose() {
    _isDisposed = true; // set the flag to true to stop the loop
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    print(width);
    print(height);

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Stack(
            children: [
              Positioned(
                bottom: 642.5,
                left: 65,
                right: 0,
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 578.5,
                left: 65,
                right: 0,
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 514.5,
                left: 65,
                right: 0,
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 450.5,
                left: 65,
                right: 0,
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 386.5,
                left: 65,
                right: 0,
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 322.5,
                left: 65,
                right: 0,
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 258.5,
                left: 65,
                right: 0,
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 194.5,
                left: 65,
                right: 0,
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 130.5,
                left: 65,
                right: 0,
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 65,
                top: 50,
                bottom: 116,
                child: Container(
                  width: 4,
                  color: const Color(0xFF245439),
                ),
              ),
              Container(
                width: double.infinity,
                height: 6,
                color: Colors.grey,
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Color(0xFF245439),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        "정차소(인문.농구장)!!",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 90,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '승차가능 | 74거9935 | 13:48:55',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF727272),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Color(0xFF245439),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        "학생회관(인문)",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 90,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '승차가능 ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF727272),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Color(0xFF245439),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        "정문(인문-하교)",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 90,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '승차가능 | 74거9935 | 13:48:55',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF727272),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Color(0xFF245439),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        "혜화로터리(하차지점)",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 90,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '승차불가 ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF727272),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Color(0xFF245439),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        "혜화역U턴지점",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 90,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '승차불가',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF727272),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Color(0xFF245439),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        "혜화역(승차장)",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 90,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '승차가능 ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF727272),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Color(0xFF245439),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        "혜화로터리(경유)",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 90,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '승차불가',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF727272),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Color(0xFF245439),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        "맥도날드 건너편",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 90,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '승차가능 | 74거9935 | 13:48:55',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF727272),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Color(0xFF245439),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        "정문(인문-등교)",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 90,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '승차가능',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF727272),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 60,
                      ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: const BoxDecoration(
                          color: Color(0xFF245439),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.circle,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        "600주년 기념관",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 90,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '승차가능',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF727272),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ), // Column이 끝나는 곳이 여기임을 주의
            ],
          ),
        ],
      ),
    );
  }
}

class Screen5 extends StatefulWidget {
  const Screen5({super.key});

  @override
  State<Screen5> createState() => _Screen5State();
}

// 버튼 디자인 생성
class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;
  final Color activeColor;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.width,
    required this.height,
    required this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: width / 51, // Switch width is 51.
      child: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
      ),
    );
  }
}

class _Screen5State extends State<Screen5> {
  bool _isFridayChecked = true;

  void _toggleFridayCheck(bool value) {
    setState(() {
      _isFridayChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF245439),
        title: const Text('인-자 셔틀'),
        elevation: 0,
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    '                          고명북/창융디 버스',
                    style: TextStyle(fontSize: 13),
                  ),
                  CustomSwitch(
                    value: _isFridayChecked,
                    onChanged: (value) {
                      setState(() {
                        _isFridayChecked = value;
                      });
                    },
                    width: 40,
                    height: 24,
                    activeColor: const Color(0xFF245439),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 15),
                        const Text(
                          '[ 인사캠 → 자과캠 ]',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DataTable(
                          columns: const [
                            DataColumn(
                                label: Text(
                              '출발시간',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            )),
                            DataColumn(
                              label: Text(
                                '비고',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                            ),
                          ],
                          rows: [
                            const DataRow(cells: [
                              DataCell(Text('07:00')),
                              DataCell(Text('금요일 07시 미운행(8시 운행)')),
                            ]),
                            const DataRow(cells: [
                              DataCell(Text('08:00')),
                              DataCell(Text('금요일만 08시 운행')),
                            ]),
                            const DataRow(cells: [
                              DataCell(Text('10:00')),
                              DataCell(Text('')),
                            ]),
                            const DataRow(cells: [
                              DataCell(Text('12:00')),
                              DataCell(Text('')),
                            ]),
                            DataRow(cells: [
                              DataCell(_isFridayChecked
                                  ? const Text('14:00')
                                  : const Text('')),
                              DataCell(_isFridayChecked
                                  ? const Text('금요일에만 운영')
                                  : const Text('')),
                            ]),
                            const DataRow(cells: [
                              DataCell(Text('15:00')),
                              DataCell(Text('')),
                            ]),
                            DataRow(cells: [
                              DataCell(_isFridayChecked
                                  ? const Text('16:20')
                                  : const Text('')),
                              DataCell(_isFridayChecked
                                  ? const Text('금요일에만 운영')
                                  : const Text('')),
                            ]),
                            const DataRow(cells: [
                              DataCell(Text('16:30')),
                              DataCell(Text('')),
                            ]),
                            const DataRow(cells: [
                              DataCell(Text('18:00')),
                              DataCell(Text('')),
                            ]),
                            DataRow(cells: [
                              DataCell(_isFridayChecked
                                  ? const Text('16:20')
                                  : const Text('')),
                              DataCell(_isFridayChecked
                                  ? const Text('금요일에만 운영')
                                  : const Text('')),
                            ]),
                            const DataRow(cells: [
                              DataCell(Text('19:00')),
                              DataCell(Text('')),
                            ]),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 30.0),
                        const Text(
                          '[ 자과캠 → 인사캠 ]',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DataTable(
                          columns: const [
                            DataColumn(
                                label: Text(
                              '출발시간',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            )),
                            DataColumn(
                              label: Text(
                                '비고',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                            ),
                          ],
                          rows: [
                            const DataRow(cells: [
                              DataCell(Text('07:00')),
                              DataCell(Text('금요일 07시 미운행(8시 운행)')),
                            ]),
                            const DataRow(cells: [
                              DataCell(Text('08:00')),
                              DataCell(Text('금요일만 08시 운행')),
                            ]),
                            DataRow(cells: [
                              DataCell(_isFridayChecked
                                  ? const Text('10:00')
                                  : const Text('')),
                              DataCell(_isFridayChecked
                                  ? const Text('금요일에만 운영')
                                  : const Text('')),
                            ]),
                            const DataRow(cells: [
                              DataCell(Text('10:30')),
                              DataCell(Text('')),
                            ]),
                            const DataRow(cells: [
                              DataCell(Text('12:00')),
                              DataCell(Text('')),
                            ]),
                            const DataRow(cells: [
                              DataCell(Text('13:30')),
                              DataCell(Text('')),
                            ]),
                            DataRow(cells: [
                              DataCell(_isFridayChecked
                                  ? const Text('14:00')
                                  : const Text('')),
                              DataCell(_isFridayChecked
                                  ? const Text('금요일에만 운영')
                                  : const Text('')),
                            ]),
                            const DataRow(cells: [
                              DataCell(Text('15:00')),
                              DataCell(Text('')),
                            ]),
                            DataRow(cells: [
                              DataCell(_isFridayChecked
                                  ? const Text('16:20')
                                  : const Text('')),
                              DataCell(_isFridayChecked
                                  ? const Text('금요일에만 운영')
                                  : const Text('')),
                            ]),
                            const DataRow(cells: [
                              DataCell(Text('16:30')),
                              DataCell(Text('')),
                            ]),
                            const DataRow(cells: [
                              DataCell(Text('18:00')),
                              DataCell(Text('')),
                            ]),
                            DataRow(cells: [
                              DataCell(_isFridayChecked
                                  ? const Text('18:10')
                                  : const Text('')),
                              DataCell(_isFridayChecked
                                  ? const Text('금요일에만 운영')
                                  : const Text('')),
                            ]),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
