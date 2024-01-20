import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:skkumap/app/pages/webview/controller/webview_controller.dart';

import 'package:skkumap/app/components/NavigationBar/custom_navigation.dart';
import 'package:skkumap/app/utils/screensize.dart';

class CustomWebViewScreen extends StatelessWidget {
  const CustomWebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String pageTitle = Get.arguments['title'];
    final String pageColor = Get.arguments['color'];
    final double screenHeight = ScreenSize.height(context);
    final double screenWidth = ScreenSize.width(context);

    final controller = Get.find<CustomWebViewController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Color(int.parse("0xFF$pageColor")),
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          CustomNavigationBar(
            title: pageTitle,
            backgroundColor: Color(int.parse("0xFF$pageColor")),
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
      ),
    );
  }
}
