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


  Future<void> getArea()async{
    SharedPreferences getdata = await SharedPreferences.getInstance();
    try{
      List<String> dataarea = List<String>();
      var responsearea = await http.get(Api.area+getdata.getString("npk"));
      Map data_area = jsonDecode(responsearea.body);

      print(data_area);



      // List data = json.decode(responsearea.body);
      // for (int i=0; i<data.length; i++){
      //   dataarea.add(data[i]["id_area"]);
      // }
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

    }
  }
}