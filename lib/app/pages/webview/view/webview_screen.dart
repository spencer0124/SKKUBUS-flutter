import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skkumap/app_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:skkumap/app/pages/webview/controller/webview_controller.dart';

import 'package:skkumap/app/components/NavigationBar/custom_navigation.dart';
import 'package:skkumap/app/utils/screensize.dart';

class KNewYearBus extends StatelessWidget {
  const KNewYearBus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenSize.height(context);
    final double screenWidth = ScreenSize.width(context);

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
            CustomNavigationBar(
              title: '귀향/귀경 버스',
              backgroundColor: AppColors.green_main,
              isDisplayLeftBtn: true,
              isDisplayRightBtn: false,
              leftBtnAction: () {
                Get.back();
              },
              rightBtnAction: () {},
              rightBtnType: CustomNavigationBtnType.info,
            ),
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.82,
              child: WebViewWidget(controller: controller.webcontroller),
            )
          ],
        ));
  }
}
