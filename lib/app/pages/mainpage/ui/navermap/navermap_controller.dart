import 'package:get/get.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:skkumap/app/pages/mainpage/ui/navermap/marker_campus.dart';
import "package:skkumap/app/model/campusmarker_model.dart";
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:skkumap/app/utils/geolocator.dart';
import 'package:geolocator/geolocator.dart';

class UltimateNMapController extends GetxController {
  final markers = <NMarker>[].obs;
  final overlays = <NOverlay>[].obs;
  final cameraPosition = const NCameraPosition(
    target: NLatLng(37.587241, 126.992858),
    zoom: 15.8,
    // bearing: 330,
    // tilt: 50,
  ).obs;

  void updateMarkers(List<CampusMarker> campusMarkers,
      {bool clearBefore = true}) {
    final newMarkers = campusMarkers.map((m) {
      return NMarker(
        id: "line${m.idNumber}",
        position: m.position,
        size: const Size(25, 25),
        icon:
            const NOverlayImage.fromAssetImage('assets/images/line_blank.png'),
        captionOffset: -22,
        caption: NOverlayCaption(
          textSize: 7,
          text: m.idNumber,
          color: Colors.black,
        ),
      );
    }).toList();

    if (clearBefore) {
      markers.value = newMarkers;
    } else {
      markers.addAll(newMarkers);
    }
  }

  Future<void> fetchMarkersFromServer() async {
    // TODO: 서버에서 CampusMarker 데이터 가져오기
    // 예시
    final fetchedMarkers = <CampusMarker>[
      CampusMarker(
          idNumber: "1", position: const NLatLng(37.587361, 126.994479)),
      CampusMarker(idNumber: "10", position: const NLatLng(37.59, 126.99)),
    ];
    updateMarkers(fetchedMarkers);
  }

  Future<void> fetchCameraPositionFromServer() async {
    // 예시 위치: 중앙도서관 근처
    const newPosition = NCameraPosition(
      target: NLatLng(37.5885, 126.9935),
      zoom: 17.5,
      bearing: 0,
      tilt: 0,
    );
    cameraPosition.value = newPosition;
  }

  Future<void> moveToCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    cameraPosition.value = NCameraPosition(
      target: NLatLng(position.latitude, position.longitude),
      zoom: cameraPosition.value.zoom,
      bearing: cameraPosition.value.bearing,
      tilt: cameraPosition.value.tilt,
    );
  }

  void updateOverlay(List<NLatLng> coords, String id) {
    overlays.value = [
      NMultipartPathOverlay(
        id: id,
        paths: [
          NMultipartPath(
            coords: coords,
            color: Colors.green,
            outlineColor: Colors.white,
          )
        ],
      ),
    ];
  }
}
