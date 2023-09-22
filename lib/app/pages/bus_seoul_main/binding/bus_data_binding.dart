import 'package:get/get.dart';

import 'package:skkumap/app/pages/bus_seoul_main/controller/bus_data_controller.dart';
import 'package:skkumap/app/data/provider/but_data_provider.dart';
import 'package:skkumap/app/data/repository/bus_data_repository.dart';

class BusDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusDataController>(() => BusDataController(
        repository: BusDataRepository(dataProvider: BusDataProvider())));
  }
}
