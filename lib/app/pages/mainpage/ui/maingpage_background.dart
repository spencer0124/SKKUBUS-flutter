import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/components/mainpage/top_search/searchbar.dart';
import 'package:skkumap/app/components/mainpage/top_search/filter.dart';
import 'package:skkumap/app/components/mainpage/top_scrollrow/scrollrow.dart';
import 'package:skkumap/app/utils/screensize.dart';
import 'package:skkumap/app/pages/mainpage/ui/navermap/navermap.dart';
import 'package:skkumap/app/pages/mainpage/ui/filter/filter_sheet.dart';

/*
snappingsheet의 child로 들어갈 background
상단 검색 창, 옵션, 네이버지도로 구성되어 있음
 */
class MainPageBackground extends StatelessWidget {
  const MainPageBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenSize.height(context);
    final double screenWidth = ScreenSize.width(context);
    final double statusBarHeight = ScreenSize.statusBarHeight(context);

    return Column(
      children: [
        Container(
          width: screenWidth,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: screenHeight - 47,
                            width: screenWidth,
                            child: buildMap(),
                          ),
                          Positioned(
                            left: 10,
                            right: 10,
                            top: statusBarHeight + 10,
                            child: Row(
                              children: [
                                const CustomSearchBar(),
                                const Spacer(),
                                CustomFilter(onFilterTap: () {
                                  Get.bottomSheet(const FilterSheet());
                                }),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: (statusBarHeight + 10 + 60),
                            child: const Center(child: ScrollableRow()),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
