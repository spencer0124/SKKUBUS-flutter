import 'package:flutter/material.dart';
import 'package:skkumap/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/controller/bus_data_detail_controller.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Map<String, String> UNIT_ID = kReleaseMode
    ? {
        'ios': dotenv.env['AdmobTestIos']!,
        'android': dotenv.env['AdmobTestAnd']!,
      }
    : {
        'ios': dotenv.env['AdmobIos']!,
        'android': dotenv.env['AdmobAnd']!,
      };

class BusDataScreenDetail extends StatelessWidget {
  const BusDataScreenDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TargetPlatform os = Theme.of(context).platform;

    BannerAd banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {},
        onAdLoaded: (_) {},
      ),
      size: AdSize.banner,
      adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
      request: const AdRequest(),
    )..load();

    final controller = Get.find<BusDetailController>();
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
          // TextButton(
          //   onPressed: () => throw Exception(),
          //   child: const Text("Throw Test Exception"),
          // ),
          Container(
            width: double.infinity,
            height: 61,
            alignment: Alignment.center,
            child: AdWidget(
              ad: banner,
            ),
          ),
          Flexible(
            child: Scrollbar(
              child: Obx(() {
                final busInfo = controller.busDetail.value;
                return ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    // Container(
                    //   color: AppColors.green_main,
                    //   child: Padding(
                    //     padding: const EdgeInsets.fromLTRB(0, 5, 0, 21),
                    //     child: Text(
                    //       busInfo.season,
                    //       textAlign: TextAlign.center,
                    //       style: const TextStyle(
                    //         fontSize: 18,
                    //         color: Colors.white,
                    //         fontFamily: 'NotoSansBold',
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
                          Row(
                            children: const [
                              Icon(
                                Icons.location_on,
                                color: AppColors.green_main,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                '정류장',
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
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(
                              busInfo.station,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: 'NotoSansRegular',
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
                            children: const [
                              Icon(
                                Icons.credit_card,
                                color: AppColors.green_main,
                              ),
                              SizedBox(
                                width: 7,
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
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                            children: const [
                              Icon(
                                Icons.timelapse_rounded,
                                color: AppColors.green_main,
                              ),
                              SizedBox(
                                width: 7,
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
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                            children: const [
                              Icon(
                                Icons.call,
                                color: AppColors.green_main,
                                size: 20,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                '연락처',
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
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '학생지원팀: ',
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
                                      child: Row(
                                        children: [
                                          const Text(
                                            '02-760-1073',
                                            style: TextStyle(
                                                color: AppColors.green_main,
                                                fontFamily: 'NotoSansBold',
                                                fontSize: 13),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            ' (클릭시 전화연결)',
                                            style: TextStyle(
                                                color: Colors.grey[900],
                                                fontFamily: 'NotoSansRegular',
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
                                      '인사캠 관리팀: ',
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
                                      child: Row(
                                        children: [
                                          const Text(
                                            '02-760-0110',
                                            style: TextStyle(
                                                color: AppColors.green_main,
                                                fontFamily: 'NotoSansBold',
                                                fontSize: 13),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            ' (클릭시 전화연결)',
                                            style: TextStyle(
                                                color: Colors.grey[900],
                                                fontFamily: 'NotoSansRegular',
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
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
