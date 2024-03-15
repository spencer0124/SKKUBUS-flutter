import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart'; // Ensure you have the GetX package installed
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skkumap/app_theme.dart';
import 'package:skkumap/app/utils/screensize.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashAd extends StatefulWidget {
  const SplashAd({Key? key}) : super(key: key);

  @override
  State<SplashAd> createState() => _SplashAdState();
}

class _SplashAdState extends State<SplashAd> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache the image here
    precacheImage(
        const AssetImage('assets/applogo/buslogo_invert.png'), context);
    precacheImage(
        const AssetImage('assets/applogo/buslogo_invert.png'), context);
  }

  Future<Map<String, String?>> fetchImageData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://ec2-13-209-48-107.ap-northeast-2.compute.amazonaws.com/ad/v1/addetail'));
      FlutterNativeSplash.remove();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return {
          'image': data['image'],
          'link': data['link'],
        };
      } else {
        print('Server error');
      }
    } catch (e) {
      print('Error: $e');
    }
    return {
      'image': null,
      'link': null,
    }; // If an error occurs, return null values
  }

  @override
  void initState() {
    super.initState();
    // Navigate to another page after 3 seconds
    Future.delayed(const Duration(milliseconds: 3900), () {
      // Use Get.toNamed to navigate to the desired route
      Get.toNamed(
          '/mainpage'); // Replace '/yourRouteName' with your actual route name
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenSize.height(context);
    double safePadding = MediaQuery.paddingOf(context).top;
    return FutureBuilder<Map<String, String?>>(
      future: fetchImageData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the data to load, display a minimal Scaffold
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SizedBox(
                height: 1,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Text('Error fetching data')),
          );
        } else if (snapshot.hasData && snapshot.data!['image'] != null) {
          // // Convert color string to a Color object
          // Color backgroundColor = Colors.white; // Default color
          // if (snapshot.data!['color'] != null) {
          //   String colorString = snapshot.data!['color']!;
          //   if (colorString.startsWith('#')) {
          //     colorString = colorString.substring(1); // Remove '#' if present
          //   }
          //   backgroundColor = Color(int.parse('0xFF$colorString'));
          // }

          return Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
              ),
              body: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Spacer(),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () async {
                                if (snapshot.data!['link'] != null) {
                                  if (await canLaunchUrl(
                                      Uri.parse(snapshot.data!['link']!))) {
                                    await launchUrl(
                                        Uri.parse(snapshot.data!['link']!));
                                  } else {
                                    Get.snackbar('오류', '해당 링크를 열 수 없습니다.');
                                  }
                                }
                              },
                              child: SizedBox(
                                width: 300.w,
                                height: 300.w,
                                child: Image.network(
                                  snapshot.data![
                                      'image']!, // Use the image URL from the Map
                                  fit: BoxFit.fitWidth,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text('Failed to load image');
                                  },
                                ),
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: (screenHeight / 2) - 150 - 216 / 2 - safePadding,
                    child: Image.asset(
                      'assets/applogo/buslogo_invert.png',
                      width: 216,
                      height: 216,
                    ),
                  )
                ],
              ));
        } else {
          return const Scaffold(
            body: Center(child: Text('No data')),
          );
        }
      },
    );
  }
}
