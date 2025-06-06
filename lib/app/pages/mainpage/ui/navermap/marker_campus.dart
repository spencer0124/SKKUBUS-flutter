import "package:flutter_naver_map/flutter_naver_map.dart";
import "package:flutter/material.dart";
import "package:skkumap/app/model/campusmarker_model.dart";
import 'package:skkumap/app/types/campus_type.dart';

const icon = NOverlayImage.fromAssetImage('assets/images/line_blank.png');

List<CampusMarker> hsscMarkers = [
  CampusMarker(
    idNumber: "1",
    position: const NLatLng(37.587361, 126.994479),
  ),
  CampusMarker(
    idNumber: "2",
    position: const NLatLng(37.587441, 126.990506),
  ),
  CampusMarker(
    idNumber: "4",
    position: const NLatLng(37.588636, 126.993209),
  ),
  CampusMarker(
    idNumber: "7",
    position: const NLatLng(37.588353, 126.994262),
  ),
  CampusMarker(
    idNumber: "8",
    position: const NLatLng(37.58752, 126.99322),
  ),
  CampusMarker(
    idNumber: "9",
    position: const NLatLng(37.586819, 126.995246),
  ),
  CampusMarker(
    idNumber: "31",
    position: const NLatLng(37.589184, 126.991539),
  ),
  CampusMarker(
    idNumber: "32",
    position: const NLatLng(37.589053, 126.992435),
  ),
  CampusMarker(
    idNumber: "33",
    position: const NLatLng(37.588572, 126.992666),
  ),
  CampusMarker(
    idNumber: "61",
    position: const NLatLng(37.587882, 126.991079),
  ),
  CampusMarker(
    idNumber: "62",
    position: const NLatLng(37.588160, 126.990868),
  ),
];

List<CampusMarker> nscMarkers = [
  CampusMarker(
    idNumber: "1",
    position: const NLatLng(37.587361, 126.994479),
  ),
];

List<NMarker> buildCampusMarkers(CampusType campusType) {
  return campusType.markername.map((campusmarker) {
    return NMarker(
        id: "line${campusmarker.idNumber}",
        position: campusmarker.position,
        size: const Size(25, 25),
        icon: icon,
        captionOffset: -22,
        caption: NOverlayCaption(
          textSize: 7,
          text: campusmarker.idNumber,
          color: Colors.black,
        ));
  }).toList();
}
