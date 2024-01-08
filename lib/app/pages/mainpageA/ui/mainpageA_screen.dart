import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:skkumap/app_theme.dart';
import 'package:sf_symbols/sf_symbols.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skkumap/app/pages/mainpageA/ui/widgetA.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:skkumap/app/pages/school_main/ui/school_widget.dart';

final double dheight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

class MainPageAScreen extends StatelessWidget {
  const MainPageAScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            // Scaffold.of(context).openDrawer();
            // controller.fetchSecureStorage();
          },
          child: const Icon(
            CupertinoIcons.list_bullet,
            // color: Colors.white,
            color: Colors.black,
            size: 25,
          ),
        ),
        title: Container(
          alignment: Alignment.centerLeft,
          width: 280.w,
          height: 30.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.grey[500]!,
              width: 1,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              '스꾸봇에게 질문하기',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontFamily: 'CJKRegular',
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                // Get.toNamed('/userchat');
              },
              child: const Icon(
                CupertinoIcons.profile_circled,
                // color: Colors.white,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        // padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              height: 10.h,
            ),
            Container(
              color: Colors.white,
              height: 100.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(
                    width: 10.w,
                  ),
                  const WidgetA(
                    titleText: '총학생회 SURE!',
                    subtitleText: '2학기 종강 이사박스 대여',
                    actionText: '더 보기',
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  const WidgetA(
                    titleText: '기말고사',
                    subtitleText: '12월 11일 (월) ~ 12월 15일 (금)',
                    actionText: '더 보기',
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  const WidgetA(
                    titleText: '기숙사',
                    subtitleText: '신관A 호실 내 화장실/샤워실 청소 일정 안내(12/13~12/15)',
                    actionText: '더 보기',
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  const WidgetA(
                    titleText: '성균관대학교',
                    subtitleText: '[최종] 2023학년도 국제동계학기 본교 외국인학생 수강신청 안내',
                    actionText: '더 보기',
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: 10.h,
            ),
            Container(
              height: 100.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey[100]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
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
                    iconName: '🪪',
                    fileName: '출입증',
                    linkText: '/busData',
                  ),
                  SchoolWidget(
                    iconName: '📆',
                    fileName: '학사일정',
                    linkText: '/foodmain',
                  ),
                  SchoolWidget(
                    iconName: '🧭',
                    fileName: '캠퍼스맵',
                    linkText: '/foodmain',
                  ),
                ],
              ),
            ),
            // Container(
            //   color: Colors.white,
            //   height: 10.h,
            // ),
            // Container(
            //   width: dwidth,
            //   height: 100.h,
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [Colors.white, Colors.grey[100]!],
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 35.h,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey[200]!,
                    width: 0.5,
                  ),
                ),
                width: dwidth,
                height: 150.h,
                child: const Text(
                  '실시간 인기글',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontFamily: 'CJKBold',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
