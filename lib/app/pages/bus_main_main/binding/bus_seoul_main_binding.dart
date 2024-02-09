import 'package:get/get.dart';

import 'package:skkumap/app/pages/bus_main_main/controller/bus_seoul_main_controller.dart';

class BusDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusDataController>(() {
      return BusDataController();
    });
  }
}
