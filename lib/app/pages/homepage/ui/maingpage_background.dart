import 'package:flutter/material.dart';
import 'package:skkumap/app/components/mainpage/top_search/searchbar.dart';
import 'package:skkumap/app/components/mainpage/top_search/filter.dart';
import 'package:skkumap/app/components/mainpage/top_scrollrow/scrollrow.dart';
import 'package:skkumap/app/utils/screensize.dart';
import 'package:skkumap/app/pages/homepage/ui/navermap.dart';

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
                            child: const Row(
                              children: [
                                CustomSearchBar(),
                                Spacer(),
                                CustomFilter(),
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