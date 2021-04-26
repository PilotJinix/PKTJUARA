import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pktjuara/helper/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget{
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  List items;
  DateTime time;


  @override
  void initState(){
    super.initState();
    getdata();
  }

  Future getdata()async{
    SharedPreferences getdata = await SharedPreferences.getInstance();
    var data = new Map<String, dynamic>();
    data["npk"] = getdata.getString("npk");
    data["status_karyawan"] = getdata.getString("is_organik");

    var response = await http.post(Api.absen_harian, body: data , headers: {
      'Accept':'application/json'
    });
    
    var dataResponse = json.decode(response.body)["data"];
    setState(() {
      items = dataResponse;
    });
  }

  Widget cardLog(items){
    return Column(
      children: [
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)
                      ),
                      color: Color(0XFFF29C12),
                    ),
                    height: 130,
                    child: Center(
                      child: Container(
                        width: 5,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 130,
                    width: 120,
                    child: Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "09.00",
                            style: TextStyle(
                                fontSize: 30,
                                color: Color(0XFF797979)
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Agenda",
                                style: TextStyle(
                                    color: Color(0XFF797979)
                                ),
                              ),
                              Text(
                                "05 Okt 2021",
                                style: TextStyle(
                                    color: Color(0XFF797979)
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Container(
                    color: Color(0XFFE9E9E9),
                    height: 125,
                    width: 2,
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    height: 130,
                    padding: EdgeInsets.only(left: 10, top: 5, bottom: 5,right: 10),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Clock-In",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0XFF797979)
                                ),
                              ),
                              Container(
                                color: Color(0XFFE9E9E9),
                                height: 2,
                              ),
                              Text(
                                "Keterangan = P20",
                                style: TextStyle(
                                    color: Color(0XFF797979),
                                    fontSize: 12
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Muhammad Agung Santoso",
                                style: TextStyle(
                                    color: Color(0XFF797979),
                                    fontSize: 12

                                ),
                              ),
                              Text(
                                "Dpt. Teknologi Informasi",
                                style: TextStyle(
                                    color: Color(0XFF797979),
                                    fontSize: 12

                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
        )
      ],
    );
  }

  Widget cardNull(){
    return Center(
      child: Text(
        "Nothing Data Avaible",
        style: TextStyle(
          color: Colors.grey
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getBody(){
    if (items==null||items.length==0){
      return cardNull();
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context,index){
        return cardLog(items[index]);
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: getBody()
    );
  }
}