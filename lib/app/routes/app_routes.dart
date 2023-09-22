import 'package:get/get.dart';
import 'package:skkumap/app/pages/bus_inja_detail/binding/ESKARA_binding.dart';
import 'package:skkumap/app/pages/bus_seoul_main/binding/bus_data_binding.dart';
import 'package:skkumap/app/pages/bus_seoul_main/ui/bus_data_screen.dart';

import 'package:skkumap/app/pages/bus_seoul_detail/ui/bus_data_detail_screen.dart';
import 'package:skkumap/app/pages/bus_inja_detail/ui/ESKARA_screen.dart';
import 'package:skkumap/app/pages/new_alert/ui/new_alert.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/',
      page: () => const BusDataScreen(), // Your Home page or initial page
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
  ];
}
