import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'dart:io' show Platform;

import 'package:url_launcher/url_launcher.dart';

class AdWidgetContainer extends StatelessWidget {
  final BannerAd? bannerAd;
  final bool isAdLoaded;
  final bool waitAdFail;

  const AdWidgetContainer({
    super.key,
    required this.bannerAd,
    required this.isAdLoaded,
    required this.waitAdFail,
  });

  @override
  Widget build(BuildContext context) {
    return isAdLoaded
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SizedBox(
              width: double.infinity,
              height: 0,
              child: AdWidget(ad: bannerAd!),
            ),
          )
        : GestureDetector(
            onTap: () async {
              // Handle alternative ad click
              final Uri url = Uri.parse('http://skkupass-app.kro.kr');
              late bool result;
              late String platform;
              late String log;

              if (Platform.isAndroid) {
                platform = 'Android';
              } else if (Platform.isIOS) {
                platform = 'IOS';
              } else {
                platform = 'unknown';
              }

              try {
                await launchUrl(url);
                result = true;
                log = 'success';
              } catch (e) {
                result = false;
                log = e.toString();
              }

              FirebaseAnalytics.instance
                  .logEvent(name: 'alternative_ad_clicked', parameters: {
                'platform': platform,
                'result': result,
                'log': log,
              });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                child: waitAdFail
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ... your alternative ad content here
                        ],
                      )
                    : null,
              ),
            ),
          );
  }
}
