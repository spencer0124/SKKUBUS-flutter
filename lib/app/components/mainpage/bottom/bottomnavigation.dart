import 'package:flutter/material.dart';
import 'package:skkumap/app/utils/screensize.dart';
import 'package:skkumap/app_theme.dart';

class Bottomnavigation extends StatelessWidget {
  const Bottomnavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenSize.height(context);
    final double screenWidth = ScreenSize.width(context);

    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // Shadow color with opacity
            spreadRadius: 2,
            blurRadius: 10, // Adjust blur radius to control the shadow's spread
            offset: const Offset(0, -1), // Vertical offset for the shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 60, right: 60),
        child: Row(
          children: [
            // Column(
            //   children: [
            //     Icon(Icons.home),
            //     Text('홈'),
            //   ],
            // ),
            // Spacer(),
            Column(
              children: [
                Image.asset(
                  'assets/images/flaticon_bus1.png',
                  width: 22,
                  color: AppColors.green_main,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  '버스',
                  style: TextStyle(
                    color: AppColors.green_main,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Image.asset(
                  'assets/images/flaticon_stop1.png',
                  width: 22,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text('정류장'),
              ],
            ),
            const Spacer(),
            const Column(
              children: [
                Icon(Icons.school),
                Text('캠퍼스'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
