import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/bus_seoul_main/controller/bus_seoul_main_controller.dart';
import 'package:skkumap/app/utils/ad_widget.dart';
import 'package:skkumap/app_theme.dart';
import 'package:flutter/services.dart';


import 'package:skkumap/app/pages/bus_seoul_main/ui/bus_seoul_main_animation.dart';
import 'package:shimmer/shimmer.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:skkumap/app/utils/return_platform.dart';

class ArrowShape extends CustomPainter {
  final Paint _paint = Paint()..color = AppColors.green_main;
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.lineTo(size.width - 5, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 5, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

final double dheight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

final PlatformType platformType = getCurrentPlatform();

class BusDataScreen extends GetView<BusDataController> {
  const BusDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey[200],
          child: Obx(
            () => AdWidgetContainer(
                bannerAd: controller.bannerAd,
                isAdLoaded: controller.isAdLoaded.value,
                waitAdFail: controller.waitAdFail.value),
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
                  height: 50.h,
                  alignment: Alignment.topCenter,
                  color: AppColors.green_main,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: AppColors.green_main,
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '인사캠 셔틀버스'.tr,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'CJKBold',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: InkWell(
                                child: const Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                  size: 27,
                                  semanticLabel: "인사캠 셔틀버스 정보 확인하기 버튼",
                                ),
                                onTap: () {
                                  FirebaseAnalytics.instance.logEvent(
                                    name: 'info_clicked',
                                  );
                                  Get.toNamed('/busDetail');
                                },
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: InkWell(
                                child: const Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 22,
                                  semanticLabel: "인사캠 셔틀버스 정보 공유하기 버튼",
                                ),
                                onTap: () async {
                                  controller.onShareClicked();
                                },
                              ),
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
                                            fontFamily: 'CJKRegular',
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
                                                                        'CJKBold',
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
                                                                        'CJKRegular',
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
                                                                      'CJKBold',
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
                                                                          'CJKRegular',
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
                                                                          'CJKRegular',
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
                                                                  'CJKBold',
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
                                                                  'CJKBold',
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
                                                                      'CJKBold',
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
                                                                          'CJKBold',
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
                                          fontFamily: 'CJKRegular',
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
        floatingActionButton: Semantics(
          label: '인사캠 버스정보 새로고침 버튼',
          button: true,
          child: Column(
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
                        child: const Icon(Icons.refresh,
                            size: 40, color: Colors.white),
                        // Lottie.asset('assets/lottie/refresh_white.json',
                        //     repeat: false,
                        //     controller: controller.animationController,
                        //     width: 200,
                        //     height: 200),
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
          ),
        ));
  }
}
