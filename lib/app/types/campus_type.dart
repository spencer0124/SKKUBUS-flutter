import 'package:skkumap/app/pages/mainpage/ui/navermap/marker_campus.dart';
import 'package:skkumap/app/model/campusmarker_model.dart';

enum CampusType { hssc, nsc }

extension CampusTypeExtension on CampusType {
  List<CampusMarker> get markername {
    switch (this) {
      case CampusType.hssc:
        return hsscMarkers;
      case CampusType.nsc:
        return nscMarkers;
    }
  }
}
