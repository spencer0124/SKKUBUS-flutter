import 'package:get/get.dart';
import 'package:skkumap/app/pages/KingoInfo/ui/kingoinfo_view.dart';
import 'package:skkumap/app/pages/KingoLogin/ui/KingoLogin_view.dart';

import 'package:skkumap/app/pages/bus_inja_detail/ui/bus_inja_detail_screen.dart';
import 'package:skkumap/app/pages/bus_inja_main/binding/bus_inja_main_binding.dart';
import 'package:skkumap/app/pages/bus_jonro_main/ui/bus_jonro_main_screen.dart';
import 'package:skkumap/app/pages/webview/view/webview_screen.dart';
import 'package:skkumap/app/pages/bus_main/binding/bus_seoul_main_binding.dart';
import 'package:skkumap/app/pages/bus_main/ui/bus_seoul_main_screen.dart';

import 'package:skkumap/app/pages/bus_detail/ui/bus_seoul_detail_screen.dart';
import 'package:skkumap/app/pages/bus_inja_main/ui/bus_inja_main_screen.dart';
import 'package:skkumap/app/pages/mainpage/ui/mainpage_screen.dart';

import 'package:skkumap/app/pages/new_alert/ui/new_alert.dart';
import 'package:skkumap/app/pages/hssc_building/hssc_building_credit.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/',
      page: () => const Mainpage(), // Your Home page or initial page
    ),
    GetPage(
        name: '/busData',
        page: () => const BusDataScreen(),
        binding: BusDataBinding()),
    GetPage(
        name: '/busDetail',
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
      name: '/jonromain',
      page: () => const JonroMainScreen(),
    ),
    GetPage(
      name: '/knewyear',
      page: () => const KNewYearBus(),
    ),
    GetPage(
      name: '/hssccredit',
      page: () => const HSSCBuildingCredit(),
    )
  ];
}
