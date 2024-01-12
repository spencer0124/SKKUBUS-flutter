import 'package:get/get.dart';
import 'package:skkumap/app/pages/bus_detail/controller/bus_seoul_detail_controller.dart';

class BusDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeoulDetailController>(() {
      return SeoulDetailController();
    });
  }
}
