import 'package:get/get.dart';
import 'package:skkumap/app/pages/LocalAuth/mainpage/controller/mainpage_controller.dart';

class mainpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainpageController>(() => MainpageController());
  }
}
