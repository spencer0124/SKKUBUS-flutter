import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

class CustomRow2 extends StatelessWidget {
  final IconData iconData;
  final String titleText;
  final String subtitleText1;
  final String subtitleText2;
  final Color containerColor;
  final String containerText;
  final String routeName;
  final bool isLoading;

  const CustomRow2({
    super.key,
    required this.iconData,
    required this.titleText,
    required this.subtitleText1,
    required this.subtitleText2,
    required this.containerColor,
    required this.containerText,
    required this.routeName,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(routeName);
      },
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: dwidth,
                height: 79.h,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      // top: BorderSide(color: Colors.grey[350]!, width: 1),
                      // bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                      // left: BorderSide(color: Colors.grey, width: 1),
                      // right: BorderSide(color: Colors.grey, width: 1),
                      ),
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
                            'assets/flaticon_stop1.png',
                            width: 22.w,
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
                                // Container(
                                //   width: 43.w,
                                //   height: 18.h,
                                //   padding:
                                //       const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                //   alignment: Alignment.center,
                                //   decoration: BoxDecoration(
                                //     color: containerColor,
                                //     borderRadius: BorderRadius.circular(5),
                                //   ),
                                //   child: Text(
                                //     containerText,
                                //     style: TextStyle(
                                //       height: 1.3.h,
                                //       color: Colors.white,
                                //       fontFamily: 'CJKMedium',
                                //       fontSize: 11,
                                //     ),
                                //     textAlign: TextAlign.start,
                                //   ),
                                // ),
                                // Container(
                                //   width: 32.w,
                                //   height: 18.h,
                                //   padding:
                                //       const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                //   alignment: Alignment.center,
                                //   decoration: BoxDecoration(
                                //     color: containerColor,
                                //     borderRadius: BorderRadius.circular(5),
                                //   ),
                                //   child: Text(
                                //     containerText,
                                //     style: TextStyle(
                                //       height: 1.3.h,
                                //       color: Colors.white,
                                //       fontFamily: 'CJKMedium',
                                //       fontSize: 11,
                                //     ),
                                //     textAlign: TextAlign.start,
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '[종로07버스]  ',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: 'CJKMedium',
                                        fontSize: 11.5,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      '[인사캠셔틀]   ',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: 'CJKMedium',
                                        fontSize: 11.5,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    isLoading
                                        ? Text(
                                            '$subtitleText1\n$subtitleText2',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontFamily: 'CJKMedium',
                                              fontSize: 11.5,
                                            ),
                                            textAlign: TextAlign.start,
                                          )
                                        : Column(
                                            children: [
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey[100]!,
                                                highlightColor: Colors.white,
                                                child: Container(
                                                  width: 100.w,
                                                  height: 12.h,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Shimmer.fromColors(
                                                baseColor: Colors.grey[100]!,
                                                highlightColor: Colors.white,
                                                child: Container(
                                                  width: 100.w,
                                                  height: 12.h,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                )

                                // Text(
                                //     'loading..\n$subtitleText2',
                                //     style: TextStyle(
                                //       color: Colors.grey[600],
                                //       fontFamily: 'CJKMedium',
                                //       fontSize: 11.5,
                                //     ),
                                //     textAlign: TextAlign.start,
                                //   ),
                              ],
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
            top: 19.2.h,
            // bottom: 0,
            child: GestureDetector(
              onTap: () {
                // Get.toNamed('kingologin');
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '',
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontFamily: 'CJKMedium',
                      fontSize: 12.5,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  // const Icon(
                  //   CupertinoIcons.right_chevron,
                  //   size: 17,
                  //   color: Colors.black,
                  // ),
                ],
              ),
            ),
          ),
          // Positioned( // lottie 애니메이션 어울리지 않아서 삭제
          //   top: 20.h,
          //   left: 2.w,
          //   child: SizedBox(
          //     width: 60.w,
          //     child: Lottie.asset(
          //       'assets/lottie/locationloading_red.json',
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
