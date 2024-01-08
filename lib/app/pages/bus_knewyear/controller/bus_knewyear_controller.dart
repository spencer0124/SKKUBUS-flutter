import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'dart:io' show Platform;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class KNewYearBusController extends GetxController {
  // currentTime

  var webcontroller = WebViewController()
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

  @override
  void onInit() async {}
}
