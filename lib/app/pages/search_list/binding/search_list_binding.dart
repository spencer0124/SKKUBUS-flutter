import 'package:get/get.dart';
import 'package:skkumap/app/pages/search_list/controller/search_list_controller.dart';

class KNewYearBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchListController>(() => SearchListController());
  }
}
