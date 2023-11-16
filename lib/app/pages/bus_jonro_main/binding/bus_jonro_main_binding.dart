import 'package:get/get.dart';

import 'package:skkumap/app/pages/bus_jonro_main/controller/bus_jonro_main_controller.dart';

class JonroMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JonroMainController>(() => JonroMainController());
  }
}
