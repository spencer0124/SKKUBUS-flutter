import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:squircle/squircle.dart';

class SchoolWidget extends StatelessWidget {
  final String iconName;
  final String fileName;
  final String linkText;

  const SchoolWidget({
    Key? key,
    required this.iconName,
    required this.fileName,
    required this.linkText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.toNamed(linkText);
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Material(
              color: Colors.white,
              shape: const SquircleBorder(
                side: BorderSide(color: Color(0xFFD2E8FC), width: 0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  iconName, // Using the iconName argument
                  style: const TextStyle(fontFamily: 'toss', fontSize: 30),
                ),
              ),
            ),
          ),
          Text(
            fileName, // Using the linkText argument
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'CJKMedium',
            ),
          ),
        ],
      ),
    );
  }
}
