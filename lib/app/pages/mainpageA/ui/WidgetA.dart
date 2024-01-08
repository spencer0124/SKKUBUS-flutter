import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skkumap/app_theme.dart';

final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

class WidgetA extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  final String actionText;

  const WidgetA({
    super.key,
    required this.titleText,
    required this.subtitleText,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      width: 190.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontFamily: 'CJKBold',
            ),
          ),
          Text(
            subtitleText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'CJKRegular',
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                actionText,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontFamily: 'CJKRegular',
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 12,
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}
