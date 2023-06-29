import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/controller/bus_data_controller.dart';
import 'package:skkumap/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:skkumap/app/ui/bus_data_screen_animation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';

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

final double dheight =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
final double dwidth =
    MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

class BusDataScreen extends GetView<BusDataController> {
  const BusDataScreen({super.key});

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

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: AppColors.green_main,
          elevation: 0,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Container(
              //   color: AppColors.green_main,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: const [
              //       // Icon(
              //       //   CupertinoIcons.bus,
              //       //   size: 20,
              //       //   color: AppColors.green_main,
              //       // ),
              //       Text(
              //         ' 인사캠 셔틀버스',
              //         style: TextStyle(
              //           fontSize: 18,
              //           color: Colors.white,
              //           fontFamily: 'NotoSansBold',
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Container(
              //   color: AppColors.green_main,
              //   height: dheight * 0.015,
              // ),
              Container(
                width: double.infinity,
                height: 61,
                alignment: Alignment.center,
                child: AdWidget(
                  ad: banner,
                ),
              ),
              Container(
                height: 0.5,
                color: Colors.grey[300],
              ),
              // SizedBox(
              //   height: dheight * 0.066,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Row(
              //           children: [
              //             InkWell(
              //               onTap: () async {
              //                 List activeBuses = controller.busDataList
              //                     .where((bus) => bus.carNumber.isNotEmpty)
              //                     .toList();
              //                 String activeBusDetails = activeBuses.map((bus) {
              //                   return '- ${bus.stationName}, ${controller.timeDifference(bus.eventDate)}';
              //                 }).join('\n');

              //                 await Share.share(
              //                     '[${controller.currentTime.value} 기준 · ${activeBuses.length}대 운행 중]\n$activeBusDetails\n\n스꾸버스 앱에서 편하게 정보를 받아보세요!\nhttp://skkubus.kro.kr');
              //               },
              //               child: SizedBox(
              //                 width: dheight * 0.03,
              //                 height: dheight * 0.03,
              //                 child: const Icon(
              //                   Icons.ios_share_outlined,
              //                   size: 23,
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               width: dwidth * 0.03,
              //             ),
              //             InkWell(
              //               onTap: () {
              //                 Get.toNamed('/busDetail');
              //               },
              //               child: Row(
              //                 children: [
              //                   SizedBox(
              //                     width: dheight * 0.03,
              //                     height: dheight * 0.03,
              //                     child: const Icon(
              //                       Icons.info_outline_rounded,
              //                       size: 25,
              //                       //color: AppColors.green_main,
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     width: dwidth * 0.008,
              //                   ),
              //                   Text(
              //                     '운행정보',
              //                     style: TextStyle(
              //                       fontSize: 13,
              //                       color: Colors.grey[800],
              //                       fontFamily: 'NotoSansBold',
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //         // Row(
              //         //   children: [
              //         //     Container(
              //         //       padding: const EdgeInsets.all(5.0),
              //         //       decoration: BoxDecoration(
              //         //         border: Border.all(
              //         //           color: Colors.grey[800]!,
              //         //           width: 1,
              //         //         ),
              //         //         borderRadius: BorderRadius.circular(10),
              //         //       ),
              //         //       child: Row(
              //         //         crossAxisAlignment: CrossAxisAlignment.center,
              //         //         children: [
              //         //           const SizedBox(
              //         //             child: Icon(
              //         //               Icons.add_road_rounded,
              //         //               size: 13,
              //         //               //color: AppColors.green_main,
              //         //             ),
              //         //           ),
              //         //           SizedBox(
              //         //             width: dwidth * 0.005,
              //         //           ),
              //         //           Text(
              //         //             '주변정류장',
              //         //             style: TextStyle(
              //         //               fontSize: 11,
              //         //               color: Colors.grey[800],
              //         //               fontFamily: 'NotoSansRegular',
              //         //             ),
              //         //           ),
              //         //         ],
              //         //       ),
              //         //     )
              //         //   ],
              //         // ),
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                height: 0.5,
                color: Colors.grey[300],
              ),
              Container(
                height: 30,
                color: Colors.grey[100],
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 4.0),
                          child: Obx(
                            () => Text(
                              '${controller.currentTime.value} 기준 · ${controller.activeBusCount.value}대 운행 중',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[800],
                                fontFamily: 'NotoSansRegular',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.5,
                color: Colors.grey[300],
              ),
              Obx(
                () {
                  if (controller.busDataList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: controller.busDataList.length,
                          itemBuilder: (_, index) {
                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    Positioned(
                                      left: dwidth *
                                          0.137, // Positioned to match the center of the icon
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 3,
                                        color: AppColors
                                            .green_main, // Change color as you need
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          dwidth * 0.055, 0, 0, 0),
                                      child: ListTile(
                                        leading: Container(
                                          width:
                                              40, // Choose a fixed width that suits your design
                                          alignment: Alignment.centerLeft,
                                          child: controller.busDataList[index]
                                                  .carNumber.isNotEmpty
                                              ? Row(
                                                  children: [
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        const PulseAnimation(
                                                          child: Icon(
                                                            Icons.circle,
                                                            size: 35,
                                                            color: AppColors
                                                                .green_main,
                                                          ),
                                                        ),
                                                        const Icon(
                                                          Icons.circle,
                                                          size: 35,
                                                          color: AppColors
                                                              .green_main,
                                                        ),
                                                        Container(
                                                          child: const Icon(
                                                            Icons
                                                                .directions_bus,
                                                            size: 17,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : // rest of your code
                                              Row(
                                                  children: [
                                                    SizedBox(
                                                      width: dwidth * 0.013,
                                                    ),
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  border: Border
                                                                      .all(
                                                                    color: AppColors
                                                                        .green_main,
                                                                    width: 2,
                                                                  ),
                                                                  color: Colors
                                                                      .white),
                                                          child: const Icon(
                                                            Icons.circle,
                                                            size: 12,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .arrow_drop_down_sharp,
                                                          size: 25,
                                                          color: AppColors
                                                              .green_main,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                        ),
                                        title: controller.busDataList[index]
                                                .carNumber.isNotEmpty
                                            ? Text(
                                                controller.busDataList[index]
                                                    .stationName,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontFamily: 'NotoSansBold',
                                                ),
                                              )
                                            : Text(
                                                controller.busDataList[index]
                                                    .stationName,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontFamily: 'NotoSansRegular',
                                                ),
                                              ),
                                        subtitle: controller.busDataList[index]
                                                .carNumber.isNotEmpty
                                            ? Text(
                                                '${controller.busDataList[index].carNumber} | ${controller.timeDifference(controller.busDataList[index].eventDate)}',
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.black,
                                                  fontFamily: 'NotoSansRegular',
                                                ),
                                              )
                                            : const Text(
                                                '',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontFamily: 'NotoSansRegular',
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: dwidth * 0.852,
                                      height: 0.5,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              List activeBuses = controller.busDataList
                  .where((bus) => bus.carNumber.isNotEmpty)
                  .toList();
              String activeBusDetails = activeBuses.map((bus) {
                return '- ${bus.stationName}, ${controller.timeDifference(bus.eventDate)}';
              }).join('\n');

              await Share.share(
                  '[${controller.currentTime.value} 기준 · ${activeBuses.length}대 운행 중]\n$activeBusDetails\n\n스꾸버스 앱에서 편하게 정보를 받아보세요!\nhttp://skkubus.kro.kr');
            },
            child: const Icon(Icons.share), // Replace with your own icon
            backgroundColor: Colors.blueGrey[700],
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              controller.refreshData();
            },
            backgroundColor: Colors.blueGrey[700],
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.translate(
                  offset: const Offset(0,
                      4.2), // 5 is the number of logical pixels to move the image down
                  child: Image.asset(
                    'lib/assets/icon/refresh.png',
                    width: 48,
                    height: 48,
                  ),
                ), // This is your refresh icon
                Obx(
                  () => Text(
                    '${controller.refreshTime.value}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontFamily: 'NotoSansBlack',
                    ),
                  ),
                ), // This is your refresh time
              ],
            ),
          ),
        ],
      ),
    );
  }
}
