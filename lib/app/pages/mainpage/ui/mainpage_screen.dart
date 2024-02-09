import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:skkumap/app/pages/KingoInfo/ui/kingoinfo_view.dart';
import 'package:skkumap/app/pages/mainpage/controller/mainpage_controller.dart';
import 'package:skkumap/app/pages/mainpage/ui/snappingsheet/option_campus.dart';
import 'package:skkumap/app/pages/mainpage/ui/snappingsheet/option_station.dart';

import 'package:snapping_sheet/snapping_sheet.dart';

import 'package:skkumap/app/components/mainpage/bottom/bottomnavigation.dart';

import '../controller/snappingsheet_controller.dart';
import 'snappingsheet/option_bus.dart';
import 'package:skkumap/app/components/mainpage/middle_snappingsheet/grabbing_box.dart';
import 'package:skkumap/app/pages/mainpage/ui/maingpage_background.dart';
import 'package:skkumap/app/utils/screensize.dart';

class Mainpage extends GetView<MainpageController> {
  const Mainpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenSize.height(context);
    final double screenWidth = ScreenSize.width(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SnappingSheet(
            controller: snappingSheetController,
            onSheetMoved: (sheetPosition) {},
            onSnapCompleted: (sheetPosition, snappingPosition) {
              // checkCurrentPosition(screenHeight, sheetPosition, snappingPosition);
            },
            lockOverflowDrag: true,
            snappingPositions: getSnappingPositions(),
            grabbingHeight: grabbingHeight,
            grabbing: const GrabbingBox(),
            sheetBelow: SnappingSheetContent(
                draggable: true,
                // snappingsheet에 어떤 child가 들어갈지 결정
                child: Obx(
                  () {
                    return _getSnappingSheetContent(
                        controller.bottomNavigationIndex.value);
                  },
                )),
            child: const MainPageBackground(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Obx(
              () {
                return Bottomnavigation(
                  index: controller.bottomNavigationIndex.value,
                  onItemTapped: (int index) {
                    controller.bottomNavigationIndex.value = index;
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget _getSnappingSheetContent(int index) {
  switch (index) {
    case 0:
      return OptionBus();
    case 1:
      return OptionStation(); // Replace with your actual widget for index 1
    case 2:
      return const OptionCampus(); // Replace with your actual widget for index 2
    default:
      return OptionBus(); // Default case
  }
}
