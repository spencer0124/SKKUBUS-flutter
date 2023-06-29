import 'package:get/get.dart';

import 'package:skkumap/app/controller/bus_data_detail_controller.dart';
import 'package:skkumap/app/data/provider/bus_data_detail_provider.dart';
import 'package:skkumap/app/data/repository/bus_data_detail_repository.dart';

class BusDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusDetailController>(() {
      final dataProvider = BusDetailDataProvider();
      final repository = BusDetailRepository(dataProvider: dataProvider);
      return BusDetailController(repository: repository);
    });
  }
}
