import 'package:flutter_naver_map/flutter_naver_map.dart';

class CampusMarker {
  final String id;
  final NLatLng position;
  String get imagepath => 'assets/images/$id.png';

  CampusMarker({
    required this.id,
    required this.position,
  });
}
