import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

class Maps extends StatefulWidget{
  @override
  _MapsState createState() => _MapsState();
}

// -8.141719,113.726656

class _MapsState extends State<Maps> {

  Future<void> marker(HereMapController hereMapController, int mark, GeoCoordinates geoCoordinates) async{
    ByteData file = await rootBundle.load("assets/pointer5.png");
    Uint8List pixel = file.buffer.asUint8List();
    MapImage mapImage = MapImage.withPixelDataAndImageFormat(pixel, ImageFormat.png);
    Anchor2D anchor2d = Anchor2D.withHorizontalAndVertical(0.5, 1);
    MapMarker mapMarker = MapMarker.withAnchor(geoCoordinates, mapImage, anchor2d);
    mapMarker.drawOrder = mark;
    hereMapController.mapScene.addMapMarker(mapMarker);
  }

  void mapCreated (HereMapController hereMapController){
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.greyDay, (error) {
      if (error != null){
        print("is Here");
        print(error.toString());
      }
    });

    marker(hereMapController, 0, GeoCoordinates(-8.141719, 113.726656));

    double distance = 1000;
    hereMapController.camera.lookAtPointWithDistance(GeoCoordinates(-8.141719, 113.726656), distance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HereMap(onMapCreated: mapCreated,),
    );
  }
}