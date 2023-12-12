import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:skkumap/app_theme.dart';

final double dheight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

class BusDataScreenDetail extends StatelessWidget {
  const BusDataScreenDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.topCenter,
              color: AppColors.green_main,
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
                        Text(
                          '인사캠 셔틀버스'.tr,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'CJKBold',
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
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 3, 15, 0),
                      // color: Colors.green,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
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
                                  fontFamily: 'CJKBold',
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 16),
                            child: Text(
                              '혜화역 1번 출구 → 학교 진입로 앞  정류소(맥도날드 앞) → 성균관대학교 정문 → 600주년 기념관 → 정차소(농구장 옆)',
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'CJKRegular',
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
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
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
                                  fontFamily: 'CJKBold',
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              '정차소(농구장 옆) → 학생회관 앞 → 학교 정문 → 혜화로터리 → 혜화역 1번 출구',
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'CJKRegular',
                                  fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
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
                          Row(
                            children: [
                              // Icon(
                              //   Icons.credit_card,
                              //   color: AppColors.green_main,
                              // ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '요금 및 결제수단'.tr,
                                style: const TextStyle(
                                  color: AppColors.green_main,
                                  fontFamily: 'CJKBold',
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
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              '요금 400원\n후불교통결제 기능 일반카드, T머니/캐시비카드 사용 가능\n현금 및 회수권 사용 불가'
                                  .tr,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'CJKRegular',
                                  fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
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
                          Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '운행시간'.tr,
                                style: const TextStyle(
                                  color: AppColors.green_main,
                                  fontFamily: 'CJKBold',
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
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              '월~금 운행, 공휴일 운행 안함\n\n[학기중] 07:00 ~ 23:00\n[방학중] 07:00 ~ 19:00'
                                  .tr,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'CJKRegular',
                                  fontSize: 13),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
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
                          Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '연락처 (클릭시 전화연결)'.tr,
                                style: const TextStyle(
                                  color: AppColors.green_main,
                                  fontFamily: 'CJKBold',
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
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '학생지원팀  '.tr,
                                      style: TextStyle(
                                          color: Colors.grey[900],
                                          fontFamily: 'CJKRegular',
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
                                                color: AppColors.green_main,
                                                fontFamily: 'CJKBold',
                                                fontSize: 13),
                                            textAlign: TextAlign.start,
                                          ),
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
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '인사캠 관리팀  '.tr,
                                      style: TextStyle(
                                          color: Colors.grey[900],
                                          fontFamily: 'CJKRegular',
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
                                                color: AppColors.green_main,
                                                fontFamily: 'CJKBold',
                                                fontSize: 13),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                            child: Divider(
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
