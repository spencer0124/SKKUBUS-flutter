import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KNewYearBusController extends GetxController {
  // currentTime

  var webcontroller = WebViewController()
    ..clearCache()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..addJavaScriptChannel(
      'knewyearmessage',
      onMessageReceived: (JavaScriptMessage message) async {
        print("clicked");
        if (await canLaunchUrl(Uri.parse(message.message)) == true) {
          launchUrl(Uri.parse(message.message));
        }
        debugPrint(message.message);
        print(message.message);
        //... anything
      },
    )
    // ..setNavigationDelegate(
    //   NavigationDelegate(
    //     onProgress: (int progress) {
    //       // Update loading bar.
    //     },
    //     // onPageStarted: (String url) {},
    //     // onPageFinished: (String url) {},
    //     // onWebResourceError: (WebResourceError error) {},
    //     // onNavigationRequest: (NavigationRequest request) {
    //     //   if (request.url.startsWith(
    //     //       'https://spencer0124.github.io/SKKUBUS_webview/#/bus/newyear')) {
    //     //     return NavigationDecision.prevent;
    //     //   }
    //     //   return NavigationDecision.navigate;
    //     // },
    //   ),
    // )
    ..loadRequest(Uri.parse(
        "https://spencer0124.github.io/SKKUBUS_webview/#/bus/newyear"));
  // ..loadRequest(Uri.parse(
  //     "http://localhost:3000/SKKUBUS_webview/#/bus/newyear/detail"));

  @override
  void onInit() async {}
}
