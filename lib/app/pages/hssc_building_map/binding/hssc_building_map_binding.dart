import 'package:get/get.dart';
import 'package:skkumap/app/pages/nsc_building_map/controller/nsc_building_map_controller.dart';

class KNewYearBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NSCBuildingMapController>(() => NSCBuildingMapController());
  }
}
