import 'package:flutter/material.dart';
import 'package:skkumap/app/components/mainpage/busrow.dart';
import 'package:skkumap/app/components/mainpage/middle_snappingsheet/stationrow.dart';
import 'package:skkumap/app_theme.dart';

class OptionStation extends StatelessWidget {
  const OptionStation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            // Obx(
            //   () =>
            CustomRow2(
              isLoading: true,
              iconData: Icons.stop_circle_rounded,
              titleText: '혜화역 1번 출구',
              subtitleText1: 'test',
              subtitleText2: 'test2',
              containerColor: Colors.black,
              containerText: '정류장',
              routeName: '/busData',
            ),
            // ),

            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
