import 'package:get/get.dart';
import 'package:skkumap/app/pages/hssc_building_map/controller/hssc_building_map_controller.dart';

class KNewYearBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HSSCBuildingMapController>(() => HSSCBuildingMapController());
  }
}
