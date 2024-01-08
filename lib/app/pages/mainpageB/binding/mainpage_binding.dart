import 'package:get/get.dart';
import 'package:skkumap/app/pages/mainpageB/controller/mainpage_controller.dart';

class MainpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainpageController>(() => MainpageController());
  }
}
