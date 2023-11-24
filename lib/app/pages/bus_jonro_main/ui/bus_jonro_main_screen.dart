import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:skkumap/app/utils/return_platform.dart';
import 'package:skkumap/app/pages/bus_jonro_main/controller/bus_jonro_main_controller.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:skkumap/app/pages/bus_seoul_main/ui/bus_seoul_main_animation.dart';

final double dheight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

final PlatformType platformType = getCurrentPlatform();

class ArrowShape extends CustomPainter {
  final Paint _paint = Paint()..color = Colors.green;
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

class JonroMainScreen extends GetView<JonroMainController> {
  const JonroMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.green,
          elevation: 0,
        ),
      ),
      body: Stack(
        children: [
          // 상단 메뉴바 부분
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 50.h,
                alignment: Alignment.topCenter,
                color: Colors.green,
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
                                color: Colors.green,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '종로07'.tr,
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
                                Icons.share,
                                color: Colors.green,
                                size: 22,
                              ),
                              onTap: () async {},
                            ),
                          ),
                          SizedBox(
                            width: 35,
                            height: 35,
                            child: InkWell(
                              child: const Icon(
                                Icons.info_outline,
                                color: Colors.green,
                                size: 27,
                                // semanticLabel: "종로07 정보 확인하기 버튼",
                              ),
                              onTap: () {
                                // Get.toNamed('/busDetail');
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
                              if (controller.currentTime.value.isEmpty) {
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
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 0, 0, 0),
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
              Obx(
                () {
                  if (controller.loading.value == false) {
                    return const Center(
                      child: Text('loading'),
                    );
                  } else {
                    return Expanded(
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: 19,
                              itemBuilder: (_, index) {
                                return SizedBox(
                                  height: 70,
                                  child: Stack(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: dwidth * 0.75,
                                            height: 1,
                                            color: index == 0
                                                ? Colors.white
                                                : Colors.grey[200],
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
                                            // 좌측 여백
                                            width: 90.w,
                                          ),
                                          Column(
                                            // 세로선, 겹친 동그라미와 아래 화살표, 세로선
                                            children: [
                                              // 가장 첫번쨰 요소는 윗쪽 세로선 그려주지 말기
                                              Container(
                                                width: 3,
                                                height: 28,
                                                color: index == 0
                                                    ? Colors.white
                                                    : Colors.green,
                                              ),
                                              Stack(
                                                alignment: Alignment.topCenter,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.green,
                                                          width: 2,
                                                          strokeAlign: BorderSide
                                                              .strokeAlignOutside,
                                                        ),
                                                        color: Colors.white),
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
                                                    color: Colors.green,
                                                  ),
                                                ],
                                              ),

                                              // 가장 마지막 요소는 아래쪽 세로선 그려주지 말기
                                              Container(
                                                width: 3,
                                                height: index == 18 ? 2 : 27,
                                                color: Colors.green,
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
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // 제목
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 10, 0, 3),
                                                    child: Text(
                                                      controller
                                                          .stationNames[index],
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'CJKRegular',
                                                      ),
                                                    ),
                                                  ),
                                                  // 내용
                                                  Obx(() {
                                                    return Text(
                                                      controller.arrmsg1[index],
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'CJKRegular',
                                                      ),
                                                    );
                                                  })
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      // 흰색 구분선
                                      Obx(
                                        () {
                                          return Positioned(
                                            top: 20.h,
                                            left: 80.w,
                                            child: controller.flag[index] == 1
                                                ? Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      const PulseAnimation(
                                                        child: Icon(
                                                          Icons.circle,
                                                          size: 35,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.circle,
                                                        size: 35,
                                                        color: Colors.green,
                                                      ),
                                                      Container(
                                                        child: const Icon(
                                                          Icons.directions_bus,
                                                          size: 17,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Container(
                                                    height: 1,
                                                    color: Colors.transparent,
                                                  ),
                                          );
                                        },
                                      ),
                                      Obx(
                                        () {
                                          return Positioned(
                                            left: 16.w,
                                            top: 28.5.h,
                                            child: controller.flag[index] == 1
                                                ? Row(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          CustomPaint(
                                                            size: const Size(
                                                                62, 18),
                                                            painter:
                                                                ArrowShape(),
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
                                                              controller.busNum[
                                                                  index],
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
                                                      ),
                                                    ],
                                                  )
                                                : Container(
                                                    height: 1,
                                                    color: Colors.transparent,
                                                  ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),

          // 버스 목록 그리기
        ],
      ),
    );
  }
}
