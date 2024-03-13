import 'package:flutter/material.dart';
import 'package:skkumap/app/components/mainpage/busrow.dart';
import 'package:skkumap/app/components/mainpage/middle_snappingsheet/stationrow.dart';
import 'package:skkumap/app_theme.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/mainpage/controller/mainpage_controller.dart';

class OptionBus extends StatelessWidget {
  OptionBus({Key? key}) : super(key: key);

  final controller = Get.find<MainpageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Obx(() {
        if (controller.mainpageBusList.value == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final busList = controller.mainpageBusList.value!.busList;

          final busWidgets = busList.map((bus) {
            return CustomRow1(
              title: bus.title.tr,
              subtitle: bus.subtitle,
              busTypeText: bus.busTypeText,
              busTypeBgColor: bus.busTypeBgColor,
              pageLink: bus.pageLink,
              altPageLink: bus.altPageLink,
              pageWebviewLink: bus.pageWebviewLink,
              noticeText: bus.noticeText,
              useAltPageLink: bus.useAltPageLink,
              showAnimation: bus.showAnimation,
              showNoticeText: bus.showNoticeText,
            );
          }).toList();

          // Use a Column to display your widgets in a scrollable view
          return SingleChildScrollView(
            child: Column(
              children: [
                // 상단 container -> notice area
                Container(color: Colors.white, height: 10),
                ...busWidgets,
                const SizedBox(height: 5),
              ],
            ),
          );
        }
      }),
    );
  }
}
