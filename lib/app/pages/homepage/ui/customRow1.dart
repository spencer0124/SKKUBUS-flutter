import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

class CustomRow1 extends StatelessWidget {
  final IconData iconData;
  final String titleText;
  final String subtitleText;
  final Color containerColor;
  final String containerText;
  final String routeName;

  const CustomRow1({
    super.key,
    required this.iconData,
    required this.titleText,
    required this.subtitleText,
    required this.containerColor,
    required this.containerText,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(routeName);
      },
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: dwidth,
                height: 65.h,
                padding: EdgeInsets.fromLTRB(0, 11.h, 0, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 0, 10, 0),
                          child: Image.asset(
                            'assets/images/flaticon_bus1.png',
                            width: 20.w,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  titleText,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'CJKMedium',
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                const Text(
                                  '  ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'CJKBold',
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Container(
                                  width: 34,
                                  height: 18.h,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    containerText,
                                    style: TextStyle(
                                      height: 1.4.h,
                                      color: Colors.white,
                                      fontFamily: 'CJKMedium',
                                      fontSize: 10.sp,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              subtitleText,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: 'CJKMedium',
                                fontSize: 11.5,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 0.7,
                endIndent: 0,
                indent: dwidth * 0.145,
              ),
            ],
          ),
          Positioned(
            right: 10.w,
            top: 10.5.h,
            // bottom: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '상세정보',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontFamily: 'CJKMedium',
                    fontSize: 12.5,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                const Icon(
                  CupertinoIcons.right_chevron,
                  size: 12,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
