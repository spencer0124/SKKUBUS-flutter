import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UserChatLifeCycle extends GetxController with WidgetsBindingObserver {
  UserChatController userChatController = Get.find<UserChatController>();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    super.onClose();

    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {}
    if (state == AppLifecycleState.inactive) {}
    if (state == AppLifecycleState.detached) {}
    if (state == AppLifecycleState.paused) {}
  }
}

class UserChatController extends GetxController {
  @override
  void onInit() async {}
}
