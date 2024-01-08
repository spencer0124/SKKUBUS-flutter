import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:skkumap/app/pages/food_main/ui/food_main_ui.dart';
import 'package:skkumap/app/pages/mainpageA/ui/mainpageA_screen.dart';
import 'package:skkumap/app/pages/mainpageB/ui/mainpage_screen.dart';
import 'package:skkumap/app/pages/pageRoute/controller/pageRoute_controller.dart';
import 'package:skkumap/app/pages/school_main/ui/school_main_screen.dart';
import 'package:skkumap/app_theme.dart';

class PageRouteScreen extends StatelessWidget {
  final PageNavigationController controller =
      Get.put(PageNavigationController());

  final List<TabItem> items = [
    const TabItem(
      icon: Icons.home,
      title: '홈',
    ),
    const TabItem(
      icon: Icons.school,
      title: '학생회',
    ),
    const TabItem(
      icon: Icons.article,
      title: '게시판',
    ),
    const TabItem(
      icon: Icons.location_on,
      title: '지도',
    ),

    const TabItem(
      icon: Icons.settings,
      title: '설정',
    ),
    // const TabItem(
    //   icon: Icons.shopping_cart_outlined,
    //   title: 'Cart',
    // ),
    // const TabItem(
    //   icon: Icons.account_box,
    //   title: 'Profile',
    // ),
  ];

  PageRouteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: const [
              MainPageAScreen(), // Replace with your actual screens
              SchoolMainScreen(),
              FoodMainScreen(),
              Mainpage(),

              FoodMainScreen(),
              // CartScreen(),
              // ProfileScreen(),
            ],
          )),
      bottomNavigationBar: Container(
        child: Obx(
          () => BottomBarDivider(
            items: items,
            backgroundColor: Colors.white,
            color: Colors.grey[600]!,
            colorSelected: AppColors.green_main,
            indexSelected: controller.selectedIndex.value,
            onTap: controller.changePage,
          ),
        ),
      ),
    );
  }
}
