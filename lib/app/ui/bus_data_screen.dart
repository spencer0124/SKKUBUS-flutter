import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/controller/bus_data_controller.dart';
import 'package:skkumap/app_theme.dart';
import 'package:flutter/services.dart';

import 'package:share_plus/share_plus.dart';

import 'package:skkumap/app/ui/bus_data_screen_animation.dart';
import 'package:shimmer/shimmer.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'dart:io' show Platform;

// import 'package:skkumap/app/ui/ESKARA_screen.dart';
// import 'package:skkumap/app/controller/ESKARA_controller.dart';

final stations = [
  '정차소(인문.농구장)',
  '학생회관(인문)',
  '정문(인문-하교)',
  '혜화로터리(하차지점)',
  '혜화역U턴지점',
  '혜화역(승차장)',
  '혜화로터리(경유)',
  '맥도날드 건너편',
  '정문(인문-등교)',
  '600주년 기념관'
];

class ArrowShape extends CustomPainter {
  final Paint _paint = Paint()
    ..color = AppColors.green_main; // Set your color here

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.lineTo(size.width - 5, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 5, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Fill the shape with color
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

final double dheight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

class BusDataScreen extends GetView<BusDataController> {
  const BusDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TargetPlatform os = Theme.of(context).platform;

    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey[200],
          child: Obx(
            () => controller.isAdLoaded.value
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: AdWidget(ad: controller.bannerAd!),
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      final Uri url = Uri.parse('http://skkupass-app.kro.kr');
                      late bool result;
                      late String platform;
                      late String log;

                      if (Platform.isAndroid) {
                        platform = 'Android';
                      } else if (Platform.isIOS) {
                        platform = 'IOS';
                      } else {
                        platform = 'unknown';
                      }

                      try {
                        await launchUrl(url);
                        result = true;
                        log = 'success';
                      } catch (e) {
                        result = false;
                        log = e.toString();
                      }

                      FirebaseAnalytics.instance.logEvent(
                          name: 'alternative_ad_clicked',
                          parameters: {
                            'platform': platform,
                            'result': result,
                            'log': log,
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Container(
                        alignment: Alignment.center,
                        // width: double.infinity,
                        height: 60,
                        child: controller.waitAdFail.value
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                    child: SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                              'assets/passlogo.png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Text(
                                    '중도, 디도 출입할때는\n스꾸패스 앱 바코드로 편안하게',
                                    style: TextStyle(
                                        height: 1.3,
                                        fontFamily: 'NotosansRegular',
                                        fontSize: 12),
                                  ),
                                ],
                              )
                            : null,
                      ),
                    ),
                  ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: AppColors.green_main,
            elevation: 0,
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.topCenter,
                  color: AppColors.green_main,
                  // color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 5.w,
                                ),
                                // SizedBox(
                                //   width: 30,
                                //   height: 30,
                                //   child: Icon(
                                //     Icons.home,
                                //     color: Colors.white,
                                //   ),
                                // ),
                                Text(
                                  'appname'.tr,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontFamily: 'ProductBold',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: InkWell(
                                        child: const Icon(
                                          Icons.info_outline,
                                          color: Colors.white,
                                          size: 27,
                                        ),
                                        onTap: () {
                                          FirebaseAnalytics.instance.logEvent(
                                            name: 'info_clicked',
                                          );
                                          Get.toNamed('/busDetail');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: InkWell(
                                        child: const Icon(
                                          Icons.share,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                        onTap: () async {
                                          FirebaseAnalytics.instance.logEvent(
                                            name: 'share_clicked',
                                          );
                                          List activeBuses = controller
                                              .busDataList
                                              .where((bus) =>
                                                  bus.carNumber.isNotEmpty)
                                              .toList();
                                          String activeBusDetails =
                                              activeBuses.map((bus) {
                                            String nextStation =
                                                Get.find<BusDataController>()
                                                    .getNextStation(
                                                        bus.stationName);
                                            return '${bus.stationName} → $nextStation\n${controller.timeDifference2(bus.eventDate)} 전 출발\n';
                                          }).join('\n');

                                          await Share.share(
                                              '인사캠 셔틀버스 실시간 위치\n[${controller.currentTime.value} 기준 · ${activeBuses.length}대 운행 중]\n\n$activeBusDetails\n스꾸버스 앱에서 편하게 정보를 받아보세요!\nskkubus-app.kro.kr');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      // width: 70,
                                      height: 35,
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        child: Text(
                                          '\u{00A0}\u{00A0}${'인자셔틀'.tr}\u{00A0}\u{00A0}',
                                          style: const TextStyle(
                                            color: AppColors.green_main,
                                            fontFamily: 'NotoSansBold',
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        onTap: () {
                                          FirebaseAnalytics.instance.logEvent(
                                            name: 'eskara_clicked',
                                          );
                                          Get.toNamed('/eskara');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 0.5,
                  color: Colors.grey[300],
                ),
                Container(
                  height: 0.5,
                  color: Colors.grey[300],
                ),
                Container(
                  height: 30,
                  color: Colors.grey[100],
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 4.0),
                            child: Obx(
                              () {
                                if (controller.currentTime.value.isEmpty ||
                                    controller.activeBusCount.value == null) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[100]!,
                                    highlightColor: Colors.white,
                                    child: Container(
                                      width: 200,
                                      height: 20,
                                      color: Colors.grey,
                                    ),
                                  );
                                } else {
                                  return Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            2, 0, 0, 0),
                                        child: Text(
                                          '${controller.currentTime.value}\u{00A0}${'기준'.tr}\u{00A0}·\u{00A0}${controller.activeBusCount.value}${'대 운행 중'.tr}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[800],
                                            fontFamily: 'NotoSansRegular',
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 0.5,
                  color: Colors.grey[300],
                ),
                Obx(
                  () {
                    if (controller.busDataList.isEmpty) {
                      return Center(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: dheight * 0.32,
                              ),
                              const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.green_main),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 8,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: controller.busDataList.length,
                                itemBuilder: (_, index) {
                                  return SizedBox(
                                    height: 69,
                                    child: Stack(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: controller
                                                          .busDataList[index]
                                                          .stationName !=
                                                      '600주년 기념관'
                                                  ? controller
                                                              .busDataList[
                                                                  index]
                                                              .stationName !=
                                                          '정차소(인문.농구장)'
                                                      ? ((controller
                                                              .busDataList[
                                                                  index - 1]
                                                              .carNumber
                                                              .isNotEmpty))
                                                          ? (controller.timeDifference3(controller
                                                                      .busDataList[
                                                                          index -
                                                                              1]
                                                                      .eventDate) >
                                                                  10)
                                                              ? dwidth * 0.72
                                                              : dwidth * 0.75
                                                          : dwidth * 0.75
                                                      : dwidth * 0.75
                                                  : dwidth * 0.75,
                                              height: 1,
                                              color: controller
                                                          .busDataList[index]
                                                          .stationName ==
                                                      '정차소(인문.농구장)'
                                                  ? Colors.white
                                                  : Colors.grey[200],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  // 좌측 여백
                                                  // width: dwidth * 0.23,
                                                  width: 90.w,
                                                ),
                                                Column(
                                                  // 세로선, 겹친 동그라미와 아래 화살표, 세로선
                                                  children: [
                                                    Container(
                                                      width: 3,
                                                      height: 27,
                                                      color: controller
                                                                  .busDataList[
                                                                      index]
                                                                  .stationName ==
                                                              '정차소(인문.농구장)'
                                                          ? Colors.white
                                                          : AppColors
                                                              .green_main,
                                                    ),
                                                    Stack(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    color: AppColors
                                                                        .green_main,
                                                                    width: 2,
                                                                    strokeAlign:
                                                                        BorderSide
                                                                            .strokeAlignOutside,
                                                                  ),
                                                                  color: Colors
                                                                      .white),
                                                          child: const Icon(
                                                            Icons.circle,
                                                            size: 15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .keyboard_arrow_down_sharp,
                                                          size: 15,
                                                          color: AppColors
                                                              .green_main,
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      width: 3,
                                                      height: controller
                                                                  .busDataList
                                                                  .length ==
                                                              index + 1
                                                          ? 1.5
                                                          : 27,
                                                      color:
                                                          AppColors.green_main,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      // 세로선과 글자 사이 간격
                                                      width: dwidth * 0.06,
                                                    ),
                                                    Column(
                                                      // 제목과 내용
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        controller
                                                                .busDataList[
                                                                    index]
                                                                .carNumber
                                                                .isNotEmpty // 제목
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        10,
                                                                        0,
                                                                        3),
                                                                child: Text(
                                                                  controller
                                                                      .busDataList[
                                                                          index]
                                                                      .stationName
                                                                      .tr,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'NotoSansBold',
                                                                  ),
                                                                ),
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        10,
                                                                        0,
                                                                        3),
                                                                child: Text(
                                                                  controller
                                                                      .busDataList[
                                                                          index]
                                                                      .stationName,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        'NotoSansRegular',
                                                                  ),
                                                                ),
                                                              ),
                                                        controller
                                                                .busDataList[
                                                                    index]
                                                                .carNumber
                                                                .isNotEmpty // 내용
                                                            ? Text(
                                                                controller.timeDifference(controller
                                                                    .busDataList[
                                                                        index]
                                                                    .eventDate),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      'NotoSansBold',
                                                                ),
                                                              )
                                                            : controller
                                                                        .busDataList[
                                                                            index]
                                                                        .stationName ==
                                                                    '정차소(인문.농구장)'
                                                                ? Text(
                                                                    '도착 정보 없음'
                                                                        .tr,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          'NotoSansRegular',
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    Get.find<
                                                                            BusDataController>()
                                                                        .getStationMessage(
                                                                            index),
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          'NotoSansRegular',
                                                                    ),
                                                                  ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        // 버스 아이콘 - 10초 이내인 경우
                                        Positioned(
                                          top: 18,
                                          left: dwidth * 0.205,
                                          child: ((controller.busDataList[index]
                                                  .carNumber.isNotEmpty))
                                              ? (controller.timeDifference3(
                                                          controller
                                                              .busDataList[
                                                                  index]
                                                              .eventDate) <
                                                      10)
                                                  ? Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        const PulseAnimation(
                                                          child: Icon(
                                                            Icons.circle,
                                                            size: 35,
                                                            color: AppColors
                                                                .green_main,
                                                          ),
                                                        ),
                                                        const Icon(
                                                          Icons.circle,
                                                          size: 35,
                                                          color: AppColors
                                                              .green_main,
                                                        ),
                                                        Container(
                                                          child: const Icon(
                                                            Icons
                                                                .directions_bus,
                                                            size: 17,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Stack(
                                                      children: [
                                                        Container(
                                                          width: 0.01,
                                                          height: 0.01,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    )
                                              : Stack(
                                                  children: [
                                                    Container(
                                                      width: 0.01,
                                                      height: 0.01,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                        ),
                                        // 10초 이내는 아니지만 정류장이 600주년 기념관인 경우 - 버스 아이콘
                                        Positioned(
                                          top: 18,
                                          left: dwidth * 0.205,
                                          child: ((controller.busDataList[index]
                                                  .carNumber.isNotEmpty))
                                              ? ((controller.busDataList[index]
                                                          .stationName) ==
                                                      '600주년 기념관')
                                                  ? Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        const PulseAnimation(
                                                          child: Icon(
                                                            Icons.circle,
                                                            size: 35,
                                                            color: AppColors
                                                                .green_main,
                                                          ),
                                                        ),
                                                        const Icon(
                                                          Icons.circle,
                                                          size: 35,
                                                          color: AppColors
                                                              .green_main,
                                                        ),
                                                        Container(
                                                          child: const Icon(
                                                            Icons
                                                                .directions_bus,
                                                            size: 17,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Stack(
                                                      children: [
                                                        Container(
                                                          width: 0.01,
                                                          height: 0.01,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    )
                                              : Stack(
                                                  children: [
                                                    Container(
                                                      width: 0.01,
                                                      height: 0.01,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                        ),

                                        // 10초 이내는 아니지만 정류장이 600주년 기념관인 경우 - 버스 번호판
                                        Positioned(
                                          top: 26,
                                          left: dwidth * 0.04,
                                          child: ((controller.busDataList[index]
                                                  .carNumber.isNotEmpty))
                                              ? ((controller.busDataList[index]
                                                          .stationName) ==
                                                      '600주년 기념관')
                                                  ? Stack(
                                                      children: [
                                                        controller
                                                                .busDataList[
                                                                    index]
                                                                .carNumber
                                                                .isNotEmpty
                                                            ? CustomPaint(
                                                                size:
                                                                    const Size(
                                                                        62, 18),
                                                                painter:
                                                                    ArrowShape(),
                                                              )
                                                            : Container(
                                                                width: 0.0001,
                                                                height: 0.0001,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  4.3, 0, 0, 0),
                                                          child: Text(
                                                            controller
                                                                .busDataList[
                                                                    index]
                                                                .carNumber,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 11,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'NotoSansBold',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Stack(
                                                      children: [
                                                        Container(
                                                          width: 0.01,
                                                          height: 0.01,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    )
                                              : Stack(
                                                  children: [
                                                    Container(
                                                      width: 0.01,
                                                      height: 0.01,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                        ),

                                        // 버스 번호판 - 10초 이내인 경우
                                        Positioned(
                                          top: 26,
                                          left: dwidth * 0.04,
                                          child: ((controller.busDataList[index]
                                                  .carNumber.isNotEmpty))
                                              ? (controller.timeDifference3(
                                                          controller
                                                              .busDataList[
                                                                  index]
                                                              .eventDate) <
                                                      10)
                                                  ? Stack(
                                                      children: [
                                                        controller
                                                                .busDataList[
                                                                    index]
                                                                .carNumber
                                                                .isNotEmpty
                                                            ? CustomPaint(
                                                                size:
                                                                    const Size(
                                                                        62, 18),
                                                                painter:
                                                                    ArrowShape(),
                                                              )
                                                            : Container(
                                                                width: 0.0001,
                                                                height: 0.0001,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  4.3, 0, 0, 0),
                                                          child: Text(
                                                            controller
                                                                .busDataList[
                                                                    index]
                                                                .carNumber,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 11,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'NotoSansBold',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Stack(
                                                      children: [
                                                        Container(
                                                          width: 0.01,
                                                          height: 0.01,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    )
                                              : Stack(
                                                  children: [
                                                    Container(
                                                      width: 0.01,
                                                      height: 0.01,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                        ),

                                        // 버스 번호판 - 10초 지난 경우 - 상단 부분 표현
                                        Positioned(
                                          bottom: -9,
                                          left: dwidth * 0.04,
                                          child: ((controller.busDataList[index]
                                                  .carNumber.isNotEmpty))
                                              ? (controller.timeDifference3(
                                                          controller
                                                              .busDataList[
                                                                  index]
                                                              .eventDate) >
                                                      10)
                                                  ? controller
                                                              .busDataList[
                                                                  index]
                                                              .stationName !=
                                                          '600주년 기념관'
                                                      ? Stack(
                                                          children: [
                                                            controller
                                                                    .busDataList[
                                                                        index]
                                                                    .carNumber
                                                                    .isNotEmpty
                                                                ? CustomPaint(
                                                                    size:
                                                                        const Size(
                                                                            62,
                                                                            18),
                                                                    painter:
                                                                        ArrowShape(),
                                                                  )
                                                                : Container(
                                                                    width:
                                                                        0.0001,
                                                                    height:
                                                                        0.0001,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                            Container(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      4.3,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child: Text(
                                                                controller
                                                                    .busDataList[
                                                                        index]
                                                                    .carNumber,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'NotoSansBold',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Stack(
                                                          children: [
                                                            Container(
                                                              width: 0.01,
                                                              height: 0.01,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          ],
                                                        )
                                                  : Stack(
                                                      children: [
                                                        Container(
                                                          width: 0.01,
                                                          height: 0.01,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    )
                                              : Stack(
                                                  children: [
                                                    Container(
                                                      width: 0.01,
                                                      height: 0.01,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                        ),

                                        // 버스 번호판 - 10초 지난 경우 - 하단 부분 표현
                                        Positioned(
                                          top: -9,
                                          left: dwidth * 0.04,
                                          child: controller.busDataList[index]
                                                      .stationName !=
                                                  '정차소(인문.농구장)'
                                              ? controller
                                                          .busDataList[index -
                                                              1]
                                                          .stationName !=
                                                      '600주년 기념관'
                                                  ? ((controller
                                                          .busDataList[index -
                                                              1]
                                                          .carNumber
                                                          .isNotEmpty))
                                                      ? (controller.timeDifference3(
                                                                  controller
                                                                      .busDataList[
                                                                          index -
                                                                              1]
                                                                      .eventDate) >
                                                              10)
                                                          ? Stack(
                                                              children: [
                                                                CustomPaint(
                                                                  size:
                                                                      const Size(
                                                                          62,
                                                                          18),
                                                                  painter:
                                                                      ArrowShape(),
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          4.3,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Text(
                                                                    controller
                                                                        .busDataList[
                                                                            index -
                                                                                1]
                                                                        .carNumber,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                          'NotoSansBold',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Stack(
                                                              children: [
                                                                Container(
                                                                  width: 0.01,
                                                                  height: 0.01,
                                                                  color: Colors
                                                                      .white,
                                                                )
                                                              ],
                                                            )
                                                      : Stack(
                                                          children: [
                                                            Container(
                                                              width: 0.01,
                                                              height: 0.01,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          ],
                                                        )
                                                  : Stack(
                                                      children: [
                                                        Container(
                                                          width: 0.01,
                                                          height: 0.01,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    )
                                              : Stack(
                                                  children: [
                                                    Container(
                                                      width: 0.01,
                                                      height: 0.01,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                        ),

                                        // 버스 아이콘 - 10초가 지나서 이동중인 경우 - 하단 부분 표현
                                        Positioned(
                                          top: -17.5,
                                          left: 80.w,
                                          child: controller.busDataList[index]
                                                      .stationName !=
                                                  '정차소(인문.농구장)'
                                              ? controller
                                                          .busDataList[index -
                                                              1]
                                                          .stationName !=
                                                      '600주년 기념관'
                                                  ? ((controller
                                                          .busDataList[index -
                                                              1]
                                                          .carNumber
                                                          .isNotEmpty))
                                                      ? (controller.timeDifference3(
                                                                  controller
                                                                      .busDataList[
                                                                          index -
                                                                              1]
                                                                      .eventDate) >
                                                              10)
                                                          ? const Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                PulseAnimation(
                                                                  child: Icon(
                                                                    Icons
                                                                        .circle,
                                                                    size: 35,
                                                                    color: AppColors
                                                                        .green_main,
                                                                  ),
                                                                ),
                                                                Icon(
                                                                  Icons.circle,
                                                                  size: 35,
                                                                  color: AppColors
                                                                      .green_main,
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .directions_bus,
                                                                  size: 17,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ],
                                                            )
                                                          : Stack(
                                                              children: [
                                                                Container(
                                                                  width: 0.01,
                                                                  height: 0.01,
                                                                  color: Colors
                                                                      .white,
                                                                )
                                                              ],
                                                            )
                                                      : Stack(
                                                          children: [
                                                            Container(
                                                              width: 0.01,
                                                              height: 0.01,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          ],
                                                        )
                                                  : Stack(
                                                      children: [
                                                        Container(
                                                          width: 0.01,
                                                          height: 0.01,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    )
                                              : Stack(
                                                  children: [
                                                    Container(
                                                      width: 0.01,
                                                      height: 0.01,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                        ),

                                        // 버스 아이콘 - 10초가 지나서 이동중인 경우 - 상단 부분 표현
                                        Positioned(
                                          bottom: -17,
                                          left: 80.w,
                                          child: controller.busDataList[index]
                                                      .stationName !=
                                                  '정차소(인문.농구장)1' // 이 경우 제외해줘야함
                                              ? controller.busDataList[index]
                                                          .stationName !=
                                                      '600주년 기념관'
                                                  ? ((controller
                                                          .busDataList[index]
                                                          .carNumber
                                                          .isNotEmpty))
                                                      ? (controller.timeDifference3(
                                                                  controller
                                                                      .busDataList[
                                                                          index]
                                                                      .eventDate) >
                                                              10)
                                                          ? Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                const PulseAnimation(
                                                                  child: Icon(
                                                                    Icons
                                                                        .circle,
                                                                    size: 35,
                                                                    color: AppColors
                                                                        .green_main,
                                                                  ),
                                                                ),
                                                                const Icon(
                                                                  Icons.circle,
                                                                  size: 35,
                                                                  color: AppColors
                                                                      .green_main,
                                                                ),
                                                                Container(
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .directions_bus,
                                                                    size: 17,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Stack(
                                                              children: [
                                                                Container(
                                                                  width: 0.01,
                                                                  height: 0.01,
                                                                  color: Colors
                                                                      .white,
                                                                )
                                                              ],
                                                            )
                                                      : Stack(
                                                          children: [
                                                            Container(
                                                              width: 0.01,
                                                              height: 0.01,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          ],
                                                        )
                                                  : Stack(
                                                      children: [
                                                        Container(
                                                          width: 0.01,
                                                          height: 0.01,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    )
                                              : Stack(
                                                  children: [
                                                    Container(
                                                      width: 0.01,
                                                      height: 0.01,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Container(
                                height: 15,
                                color: Colors.white,
                              ),
                              Container(
                                height: 2,
                                color: Colors.grey[100],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 27,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        '실시간 정보는 상황에 따라 오차가 발생할 수 있습니다'.tr,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontFamily: 'NotoSansRegulars',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 53,
              height: 53,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: () {
                    if (controller.refreshTime.value > 1 &&
                        (controller.preventAnimation.value == false)) {
                      controller.preventAnimation.value = true;
                      controller.refreshData();
                      Future.delayed(const Duration(milliseconds: 1100), () {
                        controller.preventAnimation.value = false;
                      });
                    } else {
                      print(
                          'else, ${controller.refreshTime.value} / ${controller.preventAnimation.value}');
                    }
                  },
                  backgroundColor: Colors.blueGrey[700],
                  child: Stack(alignment: Alignment.center, children: [
                    Transform.translate(
                      offset: const Offset(1, 0),
                      child: Lottie.asset('assets/lottie/refresh_white.json',
                          repeat: false,
                          controller: controller.animationController,
                          width: 200,
                          height: 200),
                    ),
                    // Obx(
                    //   () => Text(
                    //     '${controller.refreshTime.value}',
                    //     style: const TextStyle(
                    //       fontSize: 10,
                    //       color: Colors.white,
                    //       fontFamily: 'NotoSansBlack',
                    //     ),
                    //   ),
                    // ),
                  ]),
                ),
              ),
            ),
          ],
        ));
  }
}
