import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:skkumap/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

final double dheight =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.height;
final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

class FoodMainScreen extends StatelessWidget {
  const FoodMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey[10],
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: AppColors.green_main,
          elevation: 0,
          leading: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          title: const Text(
            '학식',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontFamily: 'CJKBold',
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: Icon(
                Icons.calendar_month_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 8.h,
            ),
            ButtonsTabBar(
              labelSpacing: 0,
              contentPadding: const EdgeInsets.fromLTRB(6.7, 0, 6.7, 0),
              buttonMargin: const EdgeInsets.fromLTRB(8, 5, 8, 5),
              elevation: 0,
              radius: 50,
              backgroundColor: AppColors.green_main,
              labelStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'CJKBold',
                fontSize: 14,
              ),
              unselectedLabelStyle: const TextStyle(
                color: Colors.black,
                fontFamily: 'CJKRegular',
                fontSize: 14,
              ),
              tabs: const [
                Tab(
                  text: '  학생회관  ',
                ),
                Tab(
                  text: '  교직원식당  ',
                ),
                Tab(
                  text: '  공대식당  ',
                ),
                Tab(
                  text: '  기숙사식당  ',
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            const Expanded(
              child: TabBarView(
                children: <Widget>[
                  SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Morning(),
                  ),
                  Center(
                    child: Icon(Icons.directions_transit),
                  ),
                  Center(
                    child: Icon(Icons.directions_bike),
                  ),
                  Center(
                    child: Morning(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Morning extends StatelessWidget {
  const Morning({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15.h),
          width: dwidth,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[400]!,
              width: 0.8,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 5, 12, 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.wb_sunny_sharp,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    const Text(
                      '아침',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: 'CJKBold',
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 0.8,
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '팝업델리',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[900]!,
                        fontFamily: 'CJKBold',
                      ),
                    ),
                    Text(
                      '오늘의컵밥, 샌드위치, 베이글종, 셀프라면, 웰프로틴, 다이어트밀',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[900]!,
                        fontFamily: 'CJKRegular',
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      '봄이온소반',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[900]!,
                        fontFamily: 'CJKBold',
                      ),
                    ),
                    Text(
                      '순대채소볶음, 우거지된장국, 파래김자반, 쌀밥/숭늉, 배추김치',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[900]!,
                        fontFamily: 'CJKRegular',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15.h),
          width: dwidth,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[400]!,
              width: 0.8,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(13, 5, 12, 0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.wb_sunny_sharp,
                      size: 15,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    const Text(
                      '점심',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: 'CJKBold',
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[400],
                thickness: 0.8,
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '가츠엔',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[900]!,
                        fontFamily: 'CJKBold',
                      ),
                    ),
                    Text(
                      '등심돈가스(5.5), 점보돈가스(7.7)',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[900]!,
                        fontFamily: 'CJKRegular',
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      '싱푸차이나',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[900]!,
                        fontFamily: 'CJKBold',
                      ),
                    ),
                    Text(
                      '자장면(5.0), 계란볶음밥*자장소스(5.5), 짬뽕(5.0), 부대짬뽕(6.5), 나가사키짬뽕(6.5), 탕수육(3.0), 군만두(2pcs, 1.0), 꽃빵튀김 (1.0), 공깃밥(1.0)',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[900]!,
                        fontFamily: 'CJKRegular',
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      '팝업델리',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[900]!,
                        fontFamily: 'CJKBold',
                      ),
                    ),
                    Text(
                      '셀프라면, 웰프로틴, 다이어트밀, 구운닭가슴살샐러드, 치킨텐더샐러드, 베이컨포테이토샐러드, 두부콩불고기샐러드',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[900]!,
                        fontFamily: 'CJKRegular',
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      '봄이온소반',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[900]!,
                        fontFamily: 'CJKBold',
                      ),
                    ),
                    Text(
                      '눈꽃치즈제육덮밥&김가루, 사각어묵국, 단호박고로케케찹, 배추김치 (5.0)',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[900]!,
                        fontFamily: 'CJKRegular',
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      '가츠엔',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[900]!,
                        fontFamily: 'CJKBold',
                      ),
                    ),
                    Text(
                      '치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)치즈돈가스 (6.5)',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[900]!,
                        fontFamily: 'CJKRegular',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }
}
