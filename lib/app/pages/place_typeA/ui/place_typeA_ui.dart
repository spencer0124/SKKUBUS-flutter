import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:skkumap/app/pages/LocalAuth/controller/localauth_controller.dart';

import 'package:skkumap/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_popup/flutter_popup.dart';

final double dheight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

class PlaceTypeAscreen extends GetView<LocalAuthController> {
  const PlaceTypeAscreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg_grey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: dwidth,
            child: Stack(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/map/charge/charge_logo.png',
                      width: dwidth / 2,
                      // height: 100,
                    ),
                    Image.asset(
                      'assets/map/charge/charge_hssc_01.png',
                      width: dwidth / 2,
                      // height: 100,
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey[800]!.withOpacity(0.6),
                          Colors.grey[800]!.withOpacity(0.3),
                          Colors.grey[800]!.withOpacity(0.0),
                        ],
                      ),
                    ),
                    width: dwidth,
                    height: 50,
                  ),
                ),
                Positioned(
                  top: 7,
                  left: 5,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.navigate_before,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            height: 150.h,
            width: dwidth,
            padding: const EdgeInsets.fromLTRB(15, 15, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          '충전돼지 | 수선관5층',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'CJKBold',
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          '보조배터리',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontFamily: 'CJKMedium',
                            fontSize: 12.4,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            '종료',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'CJKRegular',
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                const Text(
                  '인문사회과학캠퍼스',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CJKMedium',
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        CustomPopup(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children:
                                List.generate(5, (index) => Text('menu$index')),
                          ),
                          child: const Icon(Icons.add_circle_outline),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        color: Colors.white,
                        child: const Column(
                          children: [
                            Icon(
                              Icons.call,
                              size: 20,
                            ),
                            Text(
                              '전화',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'CJKBold',
                                fontSize: 12.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      color: Colors.white,
                      child: const Column(
                        children: [
                          Icon(
                            Icons.directions_rounded,
                            size: 20,
                          ),
                          Text(
                            '길찾기',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'CJKBold',
                              fontSize: 12.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      color: Colors.white,
                      child: const Column(
                        children: [
                          Icon(
                            Icons.share,
                            size: 20,
                          ),
                          Text(
                            '공유',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'CJKBold',
                              fontSize: 12.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            color: Colors.white,
            height: 100.h,
            width: dwidth,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 18,
                      color: Colors.grey[600],
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    const Text(
                      ' 수선관 5층 별관 통로 앞',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'CJKMedium',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      size: 18,
                      color: Colors.grey[600],
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    const Text(
                      ' 10:00 ~ 21:00',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'CJKMedium',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      size: 18,
                      color: Colors.grey[600],
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    const Text(
                      ' 1시간당 / 1,100원',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'CJKMedium',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
