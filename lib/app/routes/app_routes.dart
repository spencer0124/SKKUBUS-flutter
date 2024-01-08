import 'package:get/get.dart';
import 'package:skkumap/app/pages/KingoInfo/ui/kingoinfo_view.dart';
import 'package:skkumap/app/pages/KingoLogin/ui/KingoLogin_view.dart';
import 'package:skkumap/app/pages/LocalAuth/view/localauth_view.dart';
import 'package:skkumap/app/pages/bus_inja_detail/ui/bus_inja_detail_screen.dart';
import 'package:skkumap/app/pages/bus_inja_main/binding/bus_inja_main_binding.dart';
import 'package:skkumap/app/pages/bus_jonro_main/ui/bus_jonro_main_screen.dart';
import 'package:skkumap/app/pages/bus_knewyear/view/bus_knewyear_screen.dart';
import 'package:skkumap/app/pages/bus_seoul_main/binding/bus_seoul_main_binding.dart';
import 'package:skkumap/app/pages/bus_seoul_main/ui/bus_seoul_main_screen.dart';

import 'package:skkumap/app/pages/bus_seoul_detail/ui/bus_seoul_detail_screen.dart';
import 'package:skkumap/app/pages/bus_inja_main/ui/bus_inja_main_screen.dart';
import 'package:skkumap/app/pages/food_main/ui/food_main_ui.dart';
import 'package:skkumap/app/pages/mainpageB/ui/mainpage_screen.dart';
import 'package:skkumap/app/pages/mainpageA/ui/mainpageA_screen.dart';
import 'package:skkumap/app/pages/new_alert/ui/new_alert.dart';
import 'package:skkumap/app/pages/pageRoute/ui/pageRoute_screen.dart';
import 'package:skkumap/app/pages/place_typeA/ui/place_typeA_ui.dart';
import 'package:skkumap/app/pages/school_main/ui/school_main_screen.dart';
import 'package:skkumap/app/pages/userchat/ui/userchat_screen.dart';

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
      name: '/userchat',
      page: () => const UserChat(),
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
      name: '/localauth',
      page: () => const LocalAuthView(),
    ),
    GetPage(
      name: '/jonromain',
      page: () => const JonroMainScreen(),
    ),
    GetPage(
      name: '/placetypeA',
      page: () => const PlaceTypeAscreen(),
    ),
    GetPage(
      name: '/foodmain',
      page: () => const FoodMainScreen(),
    ),
    GetPage(
      name: '/mainpageA',
      page: () => const MainPageAScreen(),
    ),
    GetPage(
      name: '/pageroute',
      page: () => PageRouteScreen(),
    ),
    GetPage(
      name: '/schoolmain',
      page: () => const SchoolMainScreen(),
    ),
    GetPage(
      name: '/knewyear',
      page: () => const KNewYearBus(),
    )
  ];
}
