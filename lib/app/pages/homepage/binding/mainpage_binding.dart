import 'package:get/get.dart';
import 'package:skkumap/app/pages/homepage/controller/mainpage_controller.dart';

class MainpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainpageController>(() => MainpageController());
  }
}
