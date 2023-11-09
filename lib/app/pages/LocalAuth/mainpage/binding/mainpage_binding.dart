import 'package:get/get.dart';
import 'package:skkumap/app/data/provider/but_data_provider.dart';
import 'package:skkumap/app/data/repository/bus_data_repository.dart';
import 'package:skkumap/app/pages/mainpage/controller/mainpage_controller.dart';

class mainpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainpageController>(() => MainpageController());
  }
}
