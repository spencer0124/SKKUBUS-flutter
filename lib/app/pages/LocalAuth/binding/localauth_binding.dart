import 'package:get/get.dart';

import 'package:skkumap/app/pages/LocalAuth/controller/localauth_controller.dart';

class LocalAuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalAuthController>(
      () => LocalAuthController(),
    );
  }
}
