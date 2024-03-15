import 'package:flutter/material.dart';
import 'package:skkumap/app_theme.dart';
import 'package:get/get.dart';

enum BusType {
  jongro02Bus,
  jongro07Bus,
  hsscBus,
  campusBus,
}

extension BusTypeExtension on BusType {
  Color get color {
    switch (this) {
      case BusType.jongro02Bus:
        return Colors.green;
      case BusType.jongro07Bus:
        return Colors.green;
      case BusType.hsscBus:
        return AppColors.green_main;
      case BusType.campusBus:
        return AppColors.green_main;
      default:
        return AppColors.green_main;
    }
  }

  String get title {
    switch (this) {
      case BusType.jongro02Bus:
        return "종로 02".tr;
      case BusType.jongro07Bus:
        return "종로 07".tr;
      case BusType.hsscBus:
        return "인사캠 셔틀버스".tr;
      case BusType.campusBus:
        return "인자셔틀".tr;
      default:
        return "인사캠 셔틀버스".tr;
    }
  }
}
