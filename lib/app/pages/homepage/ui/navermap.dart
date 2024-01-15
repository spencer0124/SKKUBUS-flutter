import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter/material.dart';

const seoulCameraPosition = NCameraPosition(
  target: NLatLng(37.587241, 126.992858),
  zoom: 15.8,
  bearing: 330,
  tilt: 50,
);

const iconImage = NOverlayImage.fromAssetImage(
  'assets/images/locationicon.png',
);

const busImage = NOverlayImage.fromAssetImage(
  'assets/images/jonrobus.png',
);

NMarker jongrobusMarker1 = NMarker(
  size: const Size(20, 20),
  id: 'jongrobusMarker1',
  position: const NLatLng(37.583427, 127.001850),
  icon: busImage,
);

NMarker jongrobusMarker2 = NMarker(
  size: const Size(20, 20),
  id: 'jongrobusMarker2',
  position: const NLatLng(37.583427, 127.001850),
  icon: busImage,
);

NMarker jongrobusMarker3 = NMarker(
  size: const Size(20, 20),
  id: 'jongrobusMarker3',
  position: const NLatLng(37.583427, 127.001850),
  icon: busImage,
);

NMarker jongrobusMarker4 = NMarker(
  size: const Size(20, 20),
  id: 'jongrobusMarker4',
  position: const NLatLng(37.583427, 127.001850),
  icon: busImage,
);

NMarker jongrobusMarker5 = NMarker(
  size: const Size(20, 20),
  id: 'jongrobusMarker5',
  position: const NLatLng(37.583427, 127.001850),
  icon: busImage,
);
