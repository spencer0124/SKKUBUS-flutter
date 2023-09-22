import 'package:flutter/material.dart';
import 'package:skkumap/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/controller/bus_data_detail_controller.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

final double dheight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

final controller = Get.find<BusDetailController>();

class BusDataScreenDetail extends StatelessWidget {
  const BusDataScreenDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.grey[200],
      //   child: Obx(() => controller.isAdLoaded.value
      //       ? Padding(
      //           padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      //           child: SizedBox(
      //             // width: double.infinity,
      //             height: 80.h,
      //             child: AdWidget(ad: controller.bannerAd!),
      //           ),
      //         )
      //       : const Padding(
      //           padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
      //           child: SizedBox(
      //             // width: double.infinity,
      //             height: 80,
      //             child: Text('error'),
      //           ),
      //         )),
      // ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: AppColors.green_main,
          elevation: 0,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
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
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const Text(
                          '인사캠 셔틀버스',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'NotoSansBold',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.green_main,
                          size: 22,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Scrollbar(
                child: Obx(
                  () {
                    final busInfo = controller.busDetail.value;

                    if (controller.isLoading.value == false) {
                      return Center(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: dheight * 0.32,
                              ),
                              const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.green_main),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return ListView(
                        physics: const ClampingScrollPhysics(),
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(15, 3, 15, 0),
                            // color: Colors.green,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                  child: Divider(
                                    color: Colors.grey[300],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 5,
                                    ),
                                    const Text(
                                      '[혜화역 → 학교]',
                                      style: TextStyle(
                                        color: AppColors.green_main,
                                        fontFamily: 'NotoSansBold',
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 16),
                                  child: Text(
                                    busInfo.stationTypeA,
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontFamily: 'NotoSansRegular',
                                        fontSize: 13),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(15, 3, 15, 0),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                  child: Divider(
                                    color: Colors.grey[300],
                                  ),
                                ),
                                const Row(
                                  children: [
                                    // Icon(
                                    //   Icons.location_on,
                                    //   color: AppColors.green_main,
                                    // ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '[학교 → 혜화역]',
                                      style: TextStyle(
                                        color: AppColors.green_main,
                                        fontFamily: 'NotoSansBold',
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Text(
                                    busInfo.stationTypeB,
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontFamily: 'NotoSansRegular',
                                        fontSize: 13),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 16, 0, 16),
                                  child: Divider(
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    // Icon(
                                    //   Icons.credit_card,
                                    //   color: AppColors.green_main,
                                    // ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '요금 및 결제수단',
                                      style: TextStyle(
                                        color: AppColors.green_main,
                                        fontFamily: 'NotoSansBold',
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Text(
                                    '요금 ${busInfo.fee.amount.toString()}원\n${busInfo.fee.paymentMethods.join(', ')} 사용 가능\n${busInfo.fee.nonAcceptablePayments.join(' 및 ')} 사용 불가',
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontFamily: 'NotoSansRegular',
                                        fontSize: 13),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 16, 0, 0),
                                  child: Divider(
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    // Icon(
                                    //   Icons.timelapse_rounded,
                                    //   color: AppColors.green_main,
                                    // ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '운행시간',
                                      style: TextStyle(
                                        color: AppColors.green_main,
                                        fontFamily: 'NotoSansBold',
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Text(
                                    '${busInfo.time.operationDays}, ${busInfo.time.nonOperationDays}\n\n[학기중]\n평일: ${busInfo.time.duringSemester.weekday}\n토요일: ${busInfo.time.duringSemester.saturday}\n\n[방학중]\n평일: ${busInfo.time.duringVacation.weekday}\n토요일: ${busInfo.time.duringVacation.saturday}',
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontFamily: 'NotoSansRegular',
                                        fontSize: 13),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 16, 0, 0),
                                  child: Divider(
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    // Icon(
                                    //   Icons.call,
                                    //   color: AppColors.green_main,
                                    //   size: 20,
                                    // ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '연락처 (클릭시 전화연결)',
                                      style: TextStyle(
                                        color: AppColors.green_main,
                                        fontFamily: 'NotoSansBold',
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '학생지원팀  ',
                                            style: TextStyle(
                                                color: Colors.grey[900],
                                                fontFamily: 'NotoSansRegular',
                                                fontSize: 13),
                                            textAlign: TextAlign.start,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              try {
                                                await FlutterPhoneDirectCaller
                                                    .callNumber('027601073');
                                              } catch (e) {
                                                print(
                                                    "Failed to make a call due to ${e.toString()}");
                                              }
                                            },
                                            child: const Row(
                                              children: [
                                                Text(
                                                  '02-760-1073',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.green_main,
                                                      fontFamily:
                                                          'NotoSansBold',
                                                      fontSize: 13),
                                                  textAlign: TextAlign.start,
                                                ),
                                                // Text(
                                                //   ' (클릭시 전화연결)',
                                                //   style: TextStyle(
                                                //       color: Colors.grey[900],
                                                //       fontFamily: 'NotoSansRegular',
                                                //       fontSize: 13),
                                                //   textAlign: TextAlign.start,
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '인사캠 관리팀  ',
                                            style: TextStyle(
                                                color: Colors.grey[900],
                                                fontFamily: 'NotoSansRegular',
                                                fontSize: 13),
                                            textAlign: TextAlign.start,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              try {
                                                await FlutterPhoneDirectCaller
                                                    .callNumber('027600110');
                                              } catch (e) {
                                                print(
                                                    "Failed to make a call due to ${e.toString()}");
                                              }
                                            },
                                            child: const Row(
                                              children: [
                                                Text(
                                                  '02-760-0110',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.green_main,
                                                      fontFamily:
                                                          'NotoSansBold',
                                                      fontSize: 13),
                                                  textAlign: TextAlign.start,
                                                ),
                                                // Text(
                                                //   ' (클릭시 전화연결)',
                                                //   style: TextStyle(
                                                //       color: Colors.grey[900],
                                                //       fontFamily: 'NotoSansRegular',
                                                //       fontSize: 13),
                                                //   textAlign: TextAlign.start,
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 16, 0, 0),
                                  child: Divider(
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                          //   child: Column(
                          //     children: [
                          //       const Row(
                          //         children: [
                          //           // Icon(
                          //           //   Icons.call,
                          //           //   color: AppColors.green_main,
                          //           //   size: 20,
                          //           // ),
                          //           SizedBox(
                          //             width: 5,
                          //           ),
                          //           Text(
                          //             '고급 수치 설정',
                          //             style: TextStyle(
                          //               color: AppColors.green_main,
                          //               fontFamily: 'NotoSansBold',
                          //             ),
                          //             textAlign: TextAlign.start,
                          //           ),
                          //         ],
                          //       ),
                          //       const SizedBox(
                          //         height: 5,
                          //       ),
                          //       Container(
                          //         alignment: Alignment.centerLeft,
                          //         padding:
                          //             const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          //         child: Column(
                          //           children: [
                          //             Text(
                          //               'UI가 제대로 표시되지 않는다면 수치를 조절해보세요\n해당 수치와 기종을 skkupass@gmail.com으로 전송해주시면\n다음 업데이트시 수정하겠습니다\n불편을 드려 죄송합니다\n',
                          //               style: TextStyle(
                          //                   color: Colors.grey[900],
                          //                   fontFamily: 'NotoSansRegular',
                          //                   fontSize: 13),
                          //               textAlign: TextAlign.start,
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Container(
                          //         alignment: Alignment.centerLeft,
                          //         padding:
                          //             const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          //         child: Column(
                          //           children: [
                          //             Row(
                          //               children: [
                          //                 Text(
                          //                   '인사캠 관리팀  ',
                          //                   style: TextStyle(
                          //                       color: Colors.grey[900],
                          //                       fontFamily: 'NotoSansRegular',
                          //                       fontSize: 13),
                          //                   textAlign: TextAlign.start,
                          //                 ),
                          //                 InkWell(
                          //                   onTap: () async {
                          //                     try {
                          //                       await FlutterPhoneDirectCaller
                          //                           .callNumber('027600110');
                          //                     } catch (e) {
                          //                       print(
                          //                           "Failed to make a call due to ${e.toString()}");
                          //                     }
                          //                   },
                          //                   child: const Row(
                          //                     children: [
                          //                       Text(
                          //                         '02-760-0110',
                          //                         style: TextStyle(
                          //                             color:
                          //                                 AppColors.green_main,
                          //                             fontFamily:
                          //                                 'NotoSansBold',
                          //                             fontSize: 13),
                          //                         textAlign: TextAlign.start,
                          //                       ),
                          //                       // Text(
                          //                       //   ' (클릭시 전화연결)',
                          //                       //   style: TextStyle(
                          //                       //       color: Colors.grey[900],
                          //                       //       fontFamily: 'NotoSansRegular',
                          //                       //       fontSize: 13),
                          //                       //   textAlign: TextAlign.start,
                          //                       // ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding:
                          //             const EdgeInsets.fromLTRB(0, 16, 0, 0),
                          //         child: Divider(
                          //           color: Colors.grey[300],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
