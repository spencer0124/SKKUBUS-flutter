import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

// class CustomWebViewController extends GetxController {
//   var webcontroller = WebViewController()
//     ..clearCache()
//     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     ..setBackgroundColor(const Color(0x00000000))
//     ..addJavaScriptChannel(
//       'customwebviewmessage',
//       // 'knewyearmessage',
//       onMessageReceived: (JavaScriptMessage message) async {
//         // print("clicked");
//         if (await canLaunchUrl(Uri.parse(message.message)) == true) {
//           launchUrl(Uri.parse(message.message));
//         }
//         // print(message.message);
//       },
//     )
//     ..loadRequest(Uri.parse(
//         "https://spencer0124.github.io/SKKUBUS_webview/#/bus/newyear"));
// }

class CustomWebViewController extends GetxController {
  late WebViewController webcontroller;

  void initializeWebView(String webviewLink) {
    webcontroller = WebViewController()
      ..clearCache()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel(
        'customwebviewmessage',
        // 'knewyearmessage',
        onMessageReceived: (JavaScriptMessage message) async {
          // print("clicked");
          if (await canLaunchUrl(Uri.parse(message.message)) == true) {
            launchUrl(Uri.parse(message.message));
          }
          // print(message.message);
        },
      )
      ..loadRequest(Uri.parse(webviewLink));
  }
}
