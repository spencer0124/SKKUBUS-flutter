import 'package:get/get.dart';
import 'package:skkumap/app/pages/userchat/controller/userchat_controller.dart';

class UserChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserChatController>(() => UserChatController());
  }
}
