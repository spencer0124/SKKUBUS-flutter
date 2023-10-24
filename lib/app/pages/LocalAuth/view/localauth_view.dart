import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:skkumap/app/pages/LocalAuth/controller/localauth_controller.dart';

import 'package:skkumap/app_theme.dart';
// import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

final double dheight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

class LocalAuthView extends GetView<LocalAuthController> {
  const LocalAuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg_grey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: dwidth * 0.05,
            right: dwidth * 0.05,
            bottom: dheight * 0.12,
            child: SizedBox(
              width: dwidth * 0.9,
              child: ElevatedButton(
                // color: AppColors.green_main,
                onPressed: () {
                  controller.authfunction();
                  print('clicked');
                },
                child: const Text(
                  "나중에 할게요 (설정하지 않기)",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: dwidth * 0.05,
            right: dwidth * 0.05,
            bottom: dheight * 0.05,
            child: SizedBox(
              width: dwidth * 0.9,
              child: ElevatedButton(
                // color: AppColors.green_main,
                onPressed: () {
                  controller.authfunction();
                  print('clicked');
                },
                child: const Text(
                  "잠금 설정하기",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // GestureDetector(
                //   onTap: () => {
                //     controller.authfunction(),
                //     print('clicked'),
                //   },
                //   child: const Text('잠금 설정하기'),
                // ),
                const SizedBox(
                  height: 50,
                ),
                Obx(() => Text(controller.didAuthenticate == true
                    ? '설정을 완료했어요'
                    : '설정이 완료되지 않았어요')),
                // Obx(() => Text(controller.msg.value))
              ],
            )),
          ),
        ],
      ),
    );
  }
}
