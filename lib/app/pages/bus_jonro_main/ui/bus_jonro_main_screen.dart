import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skkumap/app_theme.dart';
import 'package:flutter/services.dart';

import 'package:skkumap/app/utils/return_platform.dart';
import 'package:skkumap/app/pages/bus_jonro_main/controller/bus_jonro_main_controller.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

final double dheight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

final PlatformType platformType = getCurrentPlatform();

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
          backgroundColor: AppColors.green_main,
          elevation: 0,
        ),
      ),
      body: Stack(
        children: [
          // 상단 메뉴바 부분
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
                            Icons.info_outline,
                            color: Colors.white,
                            size: 27,
                            semanticLabel: "종로07 정보 확인하기 버튼",
                          ),
                          onTap: () {
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
                          ),
                          onTap: () async {},
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
                      padding: const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 4.0),
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
          // 버스 목록 그리기
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: 20,
            itemBuilder: (_, index) {
              return SizedBox(
                height: 49,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      // 좌측 여백
                      width: 90.w,
                    ),
                    Column(
                      // 세로선, 겹친 동그라미와 아래 화살표, 세로선
                      children: [
                        Container(
                          width: 3,
                          height: 27,
                          color: AppColors.green_main,
                        ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.green_main,
                                    width: 2,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                  ),
                                  color: Colors.white),
                              child: const Icon(
                                Icons.circle,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 15,
                              color: AppColors.green_main,
                            ),
                          ],
                        ),
                        Container(
                          width: 3,
                          height:
                              // controller.busDataList.length == index + 1
                              //     ? 1.5
                              // :
                              27,
                          color: AppColors.green_main,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          // 세로선과 글자 사이 간격
                          width: dwidth * 0.06,
                        ),
                        Column(
                          // 제목과 내용
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 제목
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
                              child: Text(
                                controller.stationNames[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontFamily: 'CJKRegular',
                                ),
                              ),
                            ),
                            // 내용
                            const Text(
                              'hi',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontFamily: 'CJKBold',
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
