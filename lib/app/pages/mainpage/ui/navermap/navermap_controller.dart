import 'package:get/get.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:skkumap/app/pages/mainpage/ui/navermap/marker_campus.dart';
import "package:skkumap/app/model/campusmarker_model.dart";
import 'package:flutter/material.dart';
import 'dart:async';

class UltimateNMapController extends GetxController {
  final markers = <NMarker>[].obs;
  final overlays = <NOverlay>[].obs;
  final cameraPosition = const NCameraPosition(
    target: NLatLng(37.587241, 126.992858),
    zoom: 15.8,
    bearing: 330,
    tilt: 50,
  ).obs;

  @override
  void onInit() {
    super.onInit();

    // 3초 뒤에 fetchMarkersFromServer 호출
    Future.delayed(const Duration(seconds: 3), () {
      fetchMarkersFromServer();
    });

    Future.delayed(const Duration(seconds: 6), () {
      fetchCameraPositionFromServer();
    });
  }

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
