import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

final snappingSheetController = SnappingSheetController();

void snaptoPosition() {
  snappingSheetController.snapToPosition(
    const SnappingPosition.factor(positionFactor: 0.5),
  );
}
