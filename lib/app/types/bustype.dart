import 'package:flutter/material.dart';
import 'package:skkumap/app_theme.dart';

enum BusType {
  jonroBus,
  hsscBus,
  campusBus,
}

extension BusTypeExtension on BusType {
  Color get color {
    switch (this) {
      case BusType.jonroBus:
        return Colors.green;
      case BusType.hsscBus:
        return AppColors.green_main;
      case BusType.campusBus:
        return AppColors.green_main;
      default:
        return AppColors.green_main; // Default color
    }
  }
}
