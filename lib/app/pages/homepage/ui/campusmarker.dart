import "package:flutter_naver_map/flutter_naver_map.dart";
import "package:flutter/material.dart";

List<NMarker> buildCampusMarkers() {
  return [
    NMarker(
      id: "line1",
      position: const NLatLng(37.587361, 126.994479),
      size: const Size(25, 25),
      icon: const NOverlayImage.fromAssetImage("assets/images/line1.png"),
    ),
    NMarker(
      id: "line2",
      position: const NLatLng(37.587441, 126.990506),
      size: const Size(25, 25),
      icon: const NOverlayImage.fromAssetImage("assets/images/line2.png"),
    ),
    NMarker(
      id: "line4",
      position: const NLatLng(37.588636, 126.993209),
      size: const Size(25, 25),
      icon: const NOverlayImage.fromAssetImage("assets/images/line4.png"),
    ),
    NMarker(
      id: "line7",
      position: const NLatLng(37.588353, 126.994262),
      size: const Size(25, 25),
      icon: const NOverlayImage.fromAssetImage("assets/images/line7.png"),
    ),
    NMarker(
      id: "line8",
      position: const NLatLng(37.58752, 126.99322),
      size: const Size(25, 25),
      icon: const NOverlayImage.fromAssetImage("assets/images/line8.png"),
    ),
    NMarker(
      id: "line9",
      position: const NLatLng(37.586819, 126.995246),
      size: const Size(25, 25),
      icon: const NOverlayImage.fromAssetImage("assets/images/line9.png"),
    ),
    NMarker(
      id: "line31",
      position: const NLatLng(37.589184, 126.991539),
      size: const Size(25, 25),
      icon: const NOverlayImage.fromAssetImage("assets/images/line31.png"),
    ),
    NMarker(
      id: "line32",
      position: const NLatLng(37.589053, 126.992435),
      size: const Size(25, 25),
      icon: const NOverlayImage.fromAssetImage("assets/images/line32.png"),
    ),
    NMarker(
      id: "line33",
      position: const NLatLng(37.588572, 126.992666),
      size: const Size(25, 25),
      icon: const NOverlayImage.fromAssetImage("assets/images/line33.png"),
    ),
    NMarker(
      id: "line61",
      position: const NLatLng(37.587882, 126.991079),
      size: const Size(25, 25),
      icon: const NOverlayImage.fromAssetImage("assets/images/line61.png"),
    ),
    NMarker(
      id: "line62",
      position: const NLatLng(37.588160, 126.990868),
      size: const Size(25, 25),
      icon: const NOverlayImage.fromAssetImage("assets/images/line62.png"),
    ),
  ];
}
