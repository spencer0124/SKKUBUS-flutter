import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/userchat/controller/userchat_controller.dart';
import 'package:skkumap/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final controller = Get.find<UserChatController>();

final double dwidth =
    MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

class UserChat extends StatelessWidget {
  const UserChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey[200],
          child: SizedBox(
            height: 30.h,
            child: const Text('ad'),
          ),
        ),
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Colors.grey[300],
            elevation: 0,
          ),
        ),
        body: const Column(
          children: [
            Text('userchat'),
          ],
        ));
  }
}
