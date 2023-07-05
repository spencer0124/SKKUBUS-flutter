import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/controller/bus_data_controller.dart';
import 'package:skkumap/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:skkumap/app/ui/bus_data_screen_animation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

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

Map<String, String> UNIT_ID = kReleaseMode
    ? {
        'ios': dotenv.env['AdmobTestIos']!,
        'android': dotenv.env['AdmobTestAnd']!,
      }
    : {
        'ios': dotenv.env['AdmobIos']!,
        'android': dotenv.env['AdmobAnd']!,
      };

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
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
final double dwidth =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

class BusDataScreen extends GetView<BusDataController> {
  const BusDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TargetPlatform os = Theme.of(context).platform;

    BannerAd banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('===========Ad failed to load: $error===========\n');
          controller.adLoad.value = false;
        },
        onAdLoaded: (_) {},
      ),
      size: AdSize.banner,
      adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
      request: const AdRequest(),
    )..load();

    return Scaffold(
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
              controller.adLoad.value
                  ? Container(
                      width: double.infinity,
                      height: 61,
                      alignment: Alignment.center,
                      child: AdWidget(
                        ad: banner,
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                      width: double.infinity,
                      height: 61,
                      alignment: Alignment.topCenter,
                      color: AppColors.green_main,
                      child: const Text('인사캠 셔틀버스',
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontFamily: 'NotoSansBold',
                          )),
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
                            () => Text(
                              '${controller.currentTime.value} 기준 · ${controller.activeBusCount.value}대 운행 중',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[800],
                                fontFamily: 'NotoSansRegular',
                              ),
                            ),
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
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Expanded(
                      child: Scrollbar(
                        child: LimitedBox(
                          maxHeight: 10,
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            itemCount: controller.busDataList.length,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      Positioned(
                                        // 세로 초록선
                                        left: dwidth * 0.25,
                                        top: 0,
                                        bottom: 0,
                                        child: Container(
                                          width: 3,
                                          color: AppColors.green_main,
                                        ),
                                      ),
                                      Positioned(
                                          // 번호판
                                          left: dwidth * 0.04,
                                          top: 26,
                                          child: Stack(
                                            children: [
                                              controller.busDataList[index]
                                                      .carNumber.isNotEmpty
                                                  ? CustomPaint(
                                                      size: Size(
                                                          dwidth * 0.16, 18),
                                                      painter: ArrowShape(),
                                                    )
                                                  : Container(
                                                      width: 0.0001,
                                                      height: 0.0001,
                                                      color: Colors.white,
                                                    ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 0, 0, 0),
                                                child: Text(
                                                  controller.busDataList[index]
                                                      .carNumber,
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                    fontFamily: 'NotoSansBold',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            // 세로선 빼고 나머지 시작점 패딩
                                            dwidth * 0.167,
                                            0,
                                            0,
                                            0),
                                        child: ListTile(
                                          leading: Container(
                                            width: 35, // 글자 시작 선
                                            alignment: Alignment.centerLeft,
                                            child: controller.busDataList[index]
                                                    .carNumber.isNotEmpty
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Stack(
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
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      SizedBox(
                                                        width: dwidth * 0.013,
                                                      ),
                                                      Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: AppColors
                                                                          .green_main,
                                                                      width: 2,
                                                                    ),
                                                                    color: Colors
                                                                        .white),
                                                            child: const Icon(
                                                              Icons.circle,
                                                              size: 12,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          const Icon(
                                                            Icons
                                                                .arrow_drop_down_sharp,
                                                            size: 25,
                                                            color: AppColors
                                                                .green_main,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                          ),
                                          trailing: controller
                                                      .busDataList[index]
                                                      .stationName ==
                                                  '정차소(인문.농구장)'
                                              ? null
                                              // : Icon(
                                              //     Icons.notifications_outlined,
                                              //     color: Colors.grey[400],
                                              //     size: 21.5,
                                              //   ),
                                              : null,
                                          title: controller.busDataList[index]
                                                  .carNumber.isNotEmpty
                                              ? Text(
                                                  controller.busDataList[index]
                                                      .stationName,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontFamily: 'NotoSansBold',
                                                  ),
                                                )
                                              : Text(
                                                  controller.busDataList[index]
                                                      .stationName,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontFamily:
                                                        'NotoSansRegular',
                                                  ),
                                                ),
                                          subtitle: controller
                                                  .busDataList[index]
                                                  .carNumber
                                                  .isNotEmpty
                                              ? Text(
                                                  controller.timeDifference(
                                                      controller
                                                          .busDataList[index]
                                                          .eventDate),
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.black,
                                                    fontFamily: 'NotoSansBold',
                                                  ),
                                                )
                                              : controller.busDataList[index]
                                                          .stationName ==
                                                      '정차소(인문.농구장)'
                                                  ? const Text(
                                                      '도착 정보 없음',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'NotoSansRegular',
                                                      ),
                                                    )
                                                  : Text(
                                                      Get.find<
                                                              BusDataController>()
                                                          .getStationMessage(
                                                              index),
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'NotoSansRegular',
                                                      ),
                                                    ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: dwidth * 0.75,
                                        height: 0.5,
                                        color: Colors.grey[300],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
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
            height: 50,
            width: 50,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () async {
                  List activeBuses = controller.busDataList
                      .where((bus) => bus.carNumber.isNotEmpty)
                      .toList();
                  String activeBusDetails = activeBuses.map((bus) {
                    return '- ${bus.stationName}, ${controller.timeDifference(bus.eventDate)}';
                  }).join('\n');

                  await Share.share(
                      '[${controller.currentTime.value} 기준 · ${activeBuses.length}대 운행 중]\n$activeBusDetails\n\n스꾸버스 앱에서 편하게 정보를 받아보세요!\nhttp://skkubus.kro.kr');
                },
                child: const Icon(Icons.share), // Replace with your own icon
                backgroundColor: Colors.blueGrey[700],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            width: 50,
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  controller.refreshData();
                },
                backgroundColor: Colors.blueGrey[700],
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.translate(
                      offset: const Offset(0,
                          4.2), // 5 is the number of logical pixels to move the image down
                      child: Image.asset(
                        'lib/assets/icon/refresh.png',
                        width: 48,
                        height: 48,
                      ),
                    ), // This is your refresh icon
                    Obx(
                      () => Text(
                        '${controller.refreshTime.value}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontFamily: 'NotoSansBlack',
                        ),
                      ),
                    ), // This is your refresh time
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
