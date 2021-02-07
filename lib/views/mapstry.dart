import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';

class Maps extends StatefulWidget{
  @override
  _MapsState createState() => _MapsState();
}

// -8.141719,113.726656

class _MapsState extends State<Maps> {

  void mapCreated (HereMapController hereMapController){
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.greyDay, (error) {
      if (error != null){
        print("is Here");
        print(error.toString());
      }
    });
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