import 'package:get/get.dart';
import 'package:skkumap/app/pages/KingoInfo/ui/kingoinfo_view.dart';
import 'package:skkumap/app/pages/KingoLogin/ui/KingoLogin_view.dart';

import 'package:skkumap/app/pages/bus_inja_detail/ui/bus_inja_detail_screen.dart';
import 'package:skkumap/app/pages/bus_inja_main/binding/bus_inja_main_binding.dart';

import 'package:skkumap/app/pages/hssc_building_map/view/hssc_building_map_screen.dart';
import 'package:skkumap/app/pages/bus_main_main/binding/bus_seoul_main_binding.dart';
import 'package:skkumap/app/pages/bus_main_main/ui/bus_seoul_main_screen.dart';

import 'package:skkumap/app/pages/bus_main_detail/ui/bus_seoul_detail_screen.dart';
import 'package:skkumap/app/pages/bus_inja_main/ui/bus_inja_main_screen.dart';
import 'package:skkumap/app/pages/mainpage/ui/mainpage_screen.dart';

import 'package:skkumap/app/pages/new_alert/ui/new_alert.dart';
import 'package:skkumap/app/pages/hssc_building_credit/hssc_building_credit.dart';
import 'package:skkumap/app/pages/webview/ui/webview_screen.dart';
import 'package:skkumap/app/pages/nsc_building_map/view/nsc_building_map_screen.dart';
import 'package:skkumap/app/pages/nsc_building_credit/nsc_building_credit.dart';
import 'package:skkumap/app/pages/lostandfound/lostandfound.dart';
import 'package:skkumap/app/pages/search_list/screen/search_list_screen.dart';
import 'package:skkumap/app/pages/splash_ad/screen/splash_ad_screen.dart';

class AppRoutes {
  static final routes = [
    // GetPage(
    //   name: '/',
    //   page: () => const Mainpage(), // Your Home page or initial page
    // ),
    GetPage(
      name: '/',
      page: () => const SplashAd(),
    ),
    GetPage(
        name: '/MainbusMain',
        page: () => const BusDataScreen(),
        binding: BusDataBinding()),
    GetPage(
        name: '/MainbusDetail',
        page: () => const BusDataScreenDetail(),
        binding: BusDataBinding()),
    GetPage(
      name: '/eskara',
      page: () => const ESKARA(),
      binding: ESKARABinding(),
    ),
    GetPage(
      name: '/newalert',
      page: () => const NewAlert(),
    ),
    GetPage(
      name: '/mainpage',
      page: () => const Mainpage(),
    ),
    GetPage(
      name: '/injadetail',
      page: () => const InjaDetail(),
    ),
    GetPage(
      name: '/kingologin',
      page: () => const KingoLoginView(),
    ),
    GetPage(
      name: '/kingoinfo',
      page: () => const KingoInfoView(),
    ),
    GetPage(
      name: '/hsscbuildingmap',
      page: () => const HSSCBuildingMap(),
    ),
    GetPage(
      name: '/hsscbuildingcredit',
      page: () => const HSSCBuildingCredit(),
    ),
    GetPage(
      name: '/nscbuildingmap',
      page: () => const NSCBuildingMap(),
    ),
    GetPage(
      name: '/nscbuildingcredit',
      page: () => const NSCBuildingCredit(),
    ),
    GetPage(
      name: '/customwebview',
      page: () => const CustomWebViewScreen(),
    ),
    GetPage(
      name: '/lostandfound',
      page: () => const LostAndFound(),
    ),
    GetPage(
      name: '/searchlist',
      page: () => const SearchList(),
    ),
    GetPage(
      name: '/splashad',
      page: () => const SplashAd(),
    )
  ];
}
