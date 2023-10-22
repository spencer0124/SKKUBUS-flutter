import 'package:get/get.dart';

import 'package:skkumap/app/pages/bus_inja_main/controller/bus_inja_main_controller.dart';

class ESKARABinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ESKARAController>(() => ESKARAController());
  }
}
