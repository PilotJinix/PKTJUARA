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
    print(data);

    return data;
  }
