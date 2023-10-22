import 'package:get/get.dart';

import 'package:skkumap/app/pages/mainpage/controller/mainpage_controller.dart';

class mainpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<mainpageController>(() => mainpageController());
  }
}
