import 'package:flutter_naver_map/flutter_naver_map.dart';

class CampusMarker {
  final String idNumber;
  final NLatLng position;
  final String? name;

  CampusMarker({
    required this.idNumber,
    required this.position,
    this.name,
  });
}
