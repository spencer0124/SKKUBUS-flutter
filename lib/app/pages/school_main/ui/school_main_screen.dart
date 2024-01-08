import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:skkumap/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:squircle/squircle.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';

import 'school_widget.dart';

final double dheight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

class SchoolMainScreen extends StatelessWidget {
  const SchoolMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: AppColors.green_main,
          elevation: 0,
        ),
      ),
      body: const Column(
        children: [
          Row(
            children: [
              SchoolWidget(
                iconName: '🚍',
                fileName: '셔틀버스',
                linkText: '/busData',
              ),
              SchoolWidget(
                iconName: '🍽️',
                fileName: '학식',
                linkText: '/foodmain',
              ),
              SchoolWidget(
                iconName: '📰',
                fileName: '공지사항',
                linkText: '/foodmain',
              ),
              SchoolWidget(
                iconName: '🧭',
                fileName: '지도',
                linkText: '/foodmain',
              ),
            ],
          ),
          Row(
            children: [
              SchoolWidget(
                iconName: '🪪',
                fileName: '출입증',
                linkText: '/busData',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
