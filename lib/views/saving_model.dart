// class SavingModel {
//   String userId;
//   DateTime savingDate;
//   int amount;
//   String status;
//
//   SavingModel(this.userId, this.savingDate, this.amount, this.status);
//
//   Map<String, dynamic> toMap() => {
//         "userId": userId,
//         "savingDate": savingDate,
//         "amount": amount,
//         "status": status
//       };
//
//   SavingModel.fromMap(Map<String, dynamic> map)
//       : userId = map['userId'],
//         savingDate = DateTime.parse(map['savingDate'].toDate().toString()),
//         amount = map['amount'],
//         status = map['status'];
// }
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pktjuara/helper/api.dart';
import 'package:pktjuara/helper/custom_alert_dialog.dart';
import 'package:pktjuara/helper/getdata.dart';
import 'package:pktjuara/service/world_time.dart';
import 'package:pktjuara/views/dashboard.dart';
import 'package:pktjuara/views/mapstry2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


List areapolygon;

Future<Map> myLocate()async{
  Geolocator geolocator = new Geolocator();
  Position position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // //Trying
  // LatLng latLng = LatLng(0.186673, 117.478299);
  // //Trying

  LatLng latLng = LatLng(position.latitude, position.longitude);

  var data = new Map<String, dynamic>();
  data["latitude"] = latLng.latitude;
  data["longitude"] = latLng.longitude;
  data["latlng"] = latLng;
  print(data);

  return data;
}

void showareauser()async{
  SharedPreferences getdata = await SharedPreferences.getInstance();
  var responsearea = await http.get(Api.area+getdata.getString("npk"));
  List data = json.decode(responsearea.body);
  var locate = await myLocate();

  for(int i = 0; i < data.length; i++ ){
    if (data[i]["type_map"]=="polygon"){
      if(_checkIfValidMarker(locate["latlng"], _setPoli1(data[i]["polygon"]))){
        print("Didalam Polygons");

      }else{
        print("yah diluar polygons");
      }
      // _setPoli1(data[i]["polygon"]);
    }else{
      print(_setRadiusdistance(data[i]["lat"], data[i]["lng"], data[i]["radius"]));
    }
  }
}

Future<bool> _setRadiusdistance(String lat, String lng, var radius)async{
  Geolocator geolocator = new Geolocator();
  var datalocater = await myLocate();
  double la = double.parse(lat);
  double lo = double.parse(lng);
  Future<double> distance = geolocator.distanceBetween(la, lo, datalocater["latitude"], datalocater["longitude"]);
  double jarak = await distance / double.parse('1000');
  double skaladistance = await radius / double.parse("1000");
  return (jarak <= skaladistance);
}

// Future<double> countDistance() async {
//   Geolocator geolocator = new Geolocator();
//   var datalocater = await myLocate();
//   print(radiuscircle["radiuslat"]);
//   print(radiuscircle["radiuslng"]);
//   double la = double.parse(radiuscircle["radiuslat"]);
//   double lo = double.parse(radiuscircle["radiuslng"]);
//   Future<double> distance = geolocator.distanceBetween(la, lo, datalocater["latitude"], datalocater["longitude"]);
//   double jarak = await distance / double.parse('1000');
//   return jarak;
//
// }

List<LatLng> _setPoli1(var datapolygon) {
  List<LatLng> polygonLatLongs = List<LatLng>();
  datapolygon = datapolygon;

  List dataplg = datapolygon.split(":");

  for (int i=0; i<dataplg.length;i++){
    List data = dataplg[i].split(",");
    polygonLatLongs.add(LatLng(double.tryParse(data[0]), double.tryParse(data[1])));
  }
  // areapolygon = polygonLatLongs;
  return polygonLatLongs;
}

bool rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
  double aY = vertA.latitude;
  double bY = vertB.latitude;
  double aX = vertA.longitude;
  double bX = vertB.longitude;
  double pY = tap.latitude;
  double pX = tap.longitude;

  // print("===============");
  // print("aY = $aY");
  // print("bY = $bY");
  // print("aX = $aX");
  // print("bX = $bX");
  // print("pY = $pY");
  // print("pX = $pY");
  // print("===============");


  if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
    return false;
  }

  double m = (aY - bY) / (aX - bX);
  double bee = (-aX) * m + aY;
  double x = (pY - bee) / m;

  // print("X = $x");

  return x > pX;
}

bool _checkIfValidMarker(LatLng tap, List<LatLng> vertices) {
  int intersectCount = 0;
  // print("INI COBA ${vertices.length}");
  for (int j = 0; j < vertices.length - 1; j++) {
    // print("J = $j");
    if (rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
      intersectCount++;
    }
  }
  return ((intersectCount % 2) == 1);
}

// Future<int> cek() async{
//   int x = 0;
//   double range = await countDistance();
//   var mylatlng = await myLocate();
//   if (_checkIfValidMarker(mylatlng["latlng"], areapolygon ) || range <= 0.015){
//     x++;
//   }else{
//     x = 0;
//   }
//   return x;
// }



