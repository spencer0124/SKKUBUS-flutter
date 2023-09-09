import 'package:get/get.dart';
import 'package:skkumap/app/binding/ESKARA_binding.dart';
import 'package:skkumap/app/binding/bus_data_binding.dart';
import 'package:skkumap/app/ui/bus_data_screen.dart';
import 'package:skkumap/app/ui/bus_schedule_screen.dart';
import 'package:skkumap/app/ui/bus_setting_screen.dart';
import 'package:skkumap/app/ui/bus_data_detail_screen.dart';
import 'package:skkumap/app/ui/ESKARA_screen.dart';
import 'package:skkumap/app/ui/new_alert.dart';

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
        name: '/busSchedule',
        page: () => const BusScheduleScreen(),
        binding: BusDataBinding()),
    GetPage(
        name: '/busSetting',
        page: () => const BusSettingScreen(),
        binding: BusDataBinding()),
    GetPage(
        name: '/busDetail',
        page: () => const BusDataScreenDetail(),
        binding: BusDataBinding()),
    GetPage(
        name: '/eskara', page: () => const ESKARA(), binding: ESKARABinding()),
    GetPage(name: '/newalert', page: () => const NewAlert()),
  ];
}
