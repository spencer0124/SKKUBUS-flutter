import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/bus_inja_detail/controller/bus_inja_detail_controller.dart';
import 'package:skkumap/app/pages/food_main/ui/food_main_ui.dart';
import 'package:skkumap/app/pages/userchat/ui/userchat_screen.dart';
import 'package:skkumap/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:skkumap/app/pages/bus_knewyear/controller/bus_knewyear_controller.dart';

final double dheight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

class KNewYearBus extends StatelessWidget {
  const KNewYearBus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KNewYearBusController>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: AppColors.green_main,
            elevation: 0,
          ),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.topCenter,
              color: AppColors.green_main,
              // color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
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
                        const Text(
                          '귀향/귀경 버스',
                          style: TextStyle(
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
                                  color: AppColors.green_main,
                                  size: 27,
                                  // semanticLabel: "인사캠 셔틀버스 정보 확인하기 버튼",
                                ),
                                onTap: () {},
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: InkWell(
                                child: const Icon(
                                  Icons.share,
                                  color: AppColors.green_main,
                                  size: 22,
                                  // semanticLabel: "인사캠 셔틀버스 정보 공유하기 버튼",
                                ),
                                onTap: () async {
                                  // controller.onShareClicked();
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: dwidth,
              height: dheight * 0.82,
              child: WebViewWidget(controller: controller.webcontroller),
            )
          ],
        ));
  }
}
