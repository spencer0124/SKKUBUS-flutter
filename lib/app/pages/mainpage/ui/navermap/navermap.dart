import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter/material.dart';
import 'package:skkumap/app/pages/mainpage/ui/navermap/marker_bus.dart';
import 'package:skkumap/app/pages/mainpage/ui/navermap/marker_campus.dart';
import 'package:skkumap/app/pages/mainpage/ui/navermap/route_jongrobus.dart';
import 'package:skkumap/app/types/campus_type.dart';

const initCameraPosition = NCameraPosition(
  target: NLatLng(37.587241, 126.992858),
  zoom: 15.8,
  bearing: 330,
  tilt: 50,
);

NaverMap buildMap() {
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
        ...buildCampusMarkers(CampusType.hssc),

        // 종로 07 버스 마커는 일단 후순위로 미뤄두고, 주석처리한 상태!
        // ...buildJongroBusMarkers(jongroBusPositions),
        NMultipartPathOverlay(
          id: "jongro07Route",
          paths: [
            const NMultipartPath(
              color: Colors.green,
              outlineColor: Colors.white,
              coords: jongro07Route,
            ),
          ],
        ),
        NMultipartPathOverlay(
          id: "jongro02Route",
          paths: [
            const NMultipartPath(
              color: Colors.green,
              outlineColor: Colors.white,
              coords: jongro02Route,
            ),
          ],
        ),
      });
    },
  );
}
