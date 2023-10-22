import 'package:get/get.dart';

import 'package:skkumap/app/pages/bus_inja_detail/controller/bus_inja_detail_controller.dart';

class InjaDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InjaDetailController>(() => InjaDetailController());
  }
}
