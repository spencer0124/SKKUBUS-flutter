import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class KNewYearBusController extends GetxController {
  RxBool showInfoTap = false.obs;
  RxString placeName = "".obs;
  RxString buildingName = "".obs;
  RxString previousPlace = "".obs;
  RxString afterPlace = "".obs;
  RxString placeInfo = "".obs;
  RxString time = "".obs;
  RxString leftColor = "000000".obs;
  RxString rightColor = "000000".obs;

  late WebViewController webcontroller;

  @override
  void onInit() {
    super.onInit();
    webcontroller = WebViewController();
    setupWebViewController();
  }

  void setupWebViewController() {
    webcontroller.clearCache();
    webcontroller.loadRequest(
        Uri.parse("http://192.168.45.161:3000/SKKUBUS_webview/#/map/hssc"));
    webcontroller.enableZoom(false);
    webcontroller.clearCache();
    webcontroller.setJavaScriptMode(JavaScriptMode.unrestricted);
    webcontroller.setBackgroundColor(const Color(0x00000000));
    webcontroller.addJavaScriptChannel(
      'webtofluttermessage',
      onMessageReceived: (JavaScriptMessage message) {
        onMessageReceived(message);
      },
    );
  }

  void onMessageReceived(JavaScriptMessage message) async {
    print("webtofluttermessage");
    print(message.message);

    Map<String, dynamic> messageData = json.decode(message.message);

    String type = messageData['type'];
    String? localplacename = messageData['placename'];
    String? localbuildingname = messageData['buildingname'];
    String? localpreviousplace = messageData['previousplace'];
    String? localafterplace = messageData['afterplace'];
    String? localplaceinfo = messageData['placeinfo'];
    String? localtime = messageData['time'];
    String? localleftcolor = messageData['leftColor'];
    String? localrightcolor = messageData['rightColor'];

    if (type == "add") {
      if (localleftcolor != null) {
        leftColor.value = localleftcolor;
      } else {
        leftColor.value = "000000";
      }
      if (localrightcolor != null) {
        rightColor.value = localrightcolor;
      } else {
        rightColor.value = "000000";
      }

      if (localplacename != null) {
        placeName.value = localplacename;
      } else {
        placeName.value = "";
      }
      if (localbuildingname != null) {
        buildingName.value = localbuildingname;
      } else {
        buildingName.value = "";
      }
      if (localpreviousplace != null) {
        previousPlace.value = localpreviousplace;
      } else {
        previousPlace.value = "";
      }
      if (localafterplace != null) {
        afterPlace.value = localafterplace;
      } else {
        afterPlace.value = "";
      }
      if (localplaceinfo != null) {
        placeInfo.value = localplaceinfo;
      } else {
        placeInfo.value = "";
      }
      if (localtime != null) {
        time.value = localtime;
      } else {
        time.value = "";
      }

      showInfoTap.value = true;
    } else {
      showInfoTap.value = false;
    }
  }
}
