import 'package:get/get.dart';

import 'package:skkumap/app/controller/ESKARA_controller.dart';

class ESKARABinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ESKARAController>(() => ESKARAController());
  }
}
