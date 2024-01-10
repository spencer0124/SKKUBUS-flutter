import 'package:get/get.dart';
import 'package:skkumap/app/pages/webview/controller/webview_controller.dart';

class KNewYearBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KNewYearBusController>(() => KNewYearBusController());
  }
}
