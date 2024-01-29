import 'package:flutter/material.dart';
import 'package:skkumap/app/utils/screensize.dart';
import 'package:get/get.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = ScreenSize.width(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      alignment: Alignment.centerLeft,
      height: 49,
      width: screenWidth * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Get.toNamed('/searchlist');
        },
        child: Row(
          children: [
            Icon(
              Icons.search,
              size: 23,
              color: Colors.grey[600],
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              '성균관대 공간명/코드 검색',
              style: TextStyle(
                color: Colors.grey[400],
                fontFamily: 'CJKMedium',
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
