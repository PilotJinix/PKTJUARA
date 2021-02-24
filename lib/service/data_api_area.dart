import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pktjuara/helper/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data_Area{
  String id_user_area;
  String id_area;
  String npk;
  String kode_area;
  String nama_area;
  String lat;
  String lng;
  String radius;
  String polygon;
  String type_map;
  String start_date;
  String end_date;
  List dataarea = List<String>();



  Future<void> getArea()async{
    SharedPreferences getdata = await SharedPreferences.getInstance();
    // var responsearea = await http.get(Api.area+getdata.getString("npk"));
    // Map data = jsonDecode(responsearea.body);
    //
    // print(data);
    try{
      // List<String> dataarea = List<String>();
      var responsearea = await http.get(Api.area+getdata.getString("npk"));
      List data = jsonDecode(responsearea.body);

      print(data.length);
      for (int i=0; i<data.length; i++){
        print(data[i]);
        id_area = data[i]["id_area"];
        dataarea.add(data[i]["id_area"]);
        dataarea.add(data[i]["polygon"]);
      }



      // print(dataarea.length);
      //
      //
      // for (int i = 0; i<dataarea.length; i++){
      //   if (dataarea[i]==data[i]["id_area"]){
      //     print("Data area = ${dataarea[i]}");
      //     if (data[i]["type_map"]=="polygon"){
      //       print(data[i]["polygon"]);
      //     }else{
      //       print(data[i]["lat"]);
      //       print(data[i]["lng"]);
      //     }
      //   }
      // }


    }catch (e){
      print("Salah");
      // print(data);
    }
  }
}