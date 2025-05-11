import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter/material.dart';
import 'package:skkumap/app/pages/mainpage/ui/navermap/marker_bus.dart';
import 'package:skkumap/app/pages/mainpage/ui/navermap/marker_campus.dart';
import 'package:skkumap/app/pages/mainpage/ui/navermap/route_jongrobus.dart';
import 'package:skkumap/app/types/campus_type.dart';
import 'package:get/get.dart';
import 'package:skkumap/app/pages/mainpage/ui/navermap/navermap_controller.dart';

const initCameraPosition = NCameraPosition(
  target: NLatLng(37.587241, 126.992858),
  zoom: 15.8,
  bearing: 330,
  tilt: 50,
);

Widget buildMap() {
  final ultimateNampController = Get.put(UltimateNMapController());
  return NaverMap(
    options: const NaverMapViewOptions(
      zoomGesturesEnable: true,
      locationButtonEnable: false,
      mapType: NMapType.basic,
      logoAlign: NLogoAlign.rightBottom,
      logoClickEnable: true,
      logoMargin: EdgeInsets.all(1000),
      activeLayerGroups: [NLayerGroup.building, NLayerGroup.transit],
      initialCameraPosition: initCameraPosition,
    ),
    onMapReady: (mapcontroller) {
      mapcontroller.addOverlayAll({
        // 초기 마커 세팅
        ...ultimateNampController.markers,
      });

      // 마커 갱신
      ever(ultimateNampController.markers, (_) {
        mapcontroller.clearOverlays(); // 필요시 clear
        mapcontroller.addOverlayAll({...ultimateNampController.markers});
      });

      // 카메라 갱신
      ever<NCameraPosition>(ultimateNampController.cameraPosition, (pos) {
        mapcontroller.updateCamera(
          NCameraUpdate.withParams(
            target: pos.target,
            zoom: pos.zoom,
            tilt: pos.tilt,
            bearing: pos.bearing,
          ),
        );
      });

      // // 인사캠 건물 번호마커
      // ...buildCampusMarkers(CampusType.hssc),

      // // 종로07버스 노선 오버레이
      // NMultipartPathOverlay(
      //   id: "jongro07Route",
      //   paths: [
      //     const NMultipartPath(
      //       color: Colors.green,
      //       outlineColor: Colors.white,
      //       coords: jongro07Route,
      //     ),
      //   ],
      // ),

      // // 종로02버스 노선 오버레이
      // NMultipartPathOverlay(
      //   id: "jongro02Route",
      //   paths: [
      //     const NMultipartPath(
      //       color: Colors.green,
      //       outlineColor: Colors.white,
      //       coords: jongro02Route,
      //     ),
      //   ],
      // ),
    },
  );
}
