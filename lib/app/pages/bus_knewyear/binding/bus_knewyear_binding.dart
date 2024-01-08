import 'package:get/get.dart';
import 'package:skkumap/app/pages/bus_knewyear/controller/bus_knewyear_controller.dart';

class KNewYearBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KNewYearBusController>(() => KNewYearBusController());
  }
}
