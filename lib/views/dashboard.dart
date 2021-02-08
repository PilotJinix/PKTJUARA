import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:pktjuara/service/world_time.dart';
import 'package:pktjuara/views/mapstry2.dart';

class dashboard extends StatefulWidget{


  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  String time ="loading";
  String location ="loading";
  String flag ="loading";
  String url ="loading";

  // var data = new Map<String, dynamic>();
  // data["location"] ="";
  // data;["flag"] = "",
  // data["url"] ="",
  // print(data);

  void setupTime()async{
    WorldTime intance = WorldTime(location: "Bontang", flag: "Indonesia.png", url: "Asia/Kuala_Lumpur");
    await intance.getTime();
    print(intance.time);
    print(intance.location);
    setState(() {
      time = intance.time;
      location = intance.location;
      flag = intance.flag;
      url = intance.url;
    });
  }

  @override
  void initState(){
    super.initState();
    setupTime();
  }

  Widget header(){
    return ListTile(
      title: Text("SELAMAT DATANG",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
      trailing: FaIcon(
        FontAwesomeIcons.mapMarkedAlt,
        color: Colors.white,
      ),
      onTap: (){

      },
    );
  }

  Widget profile(){
    return ListTile(
      title: Text("Muhammad Agung Santoso",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold
      ),),
      subtitle: Text("182410103081",
      style: TextStyle(
        color: Colors.white
      ),),
      leading: FaIcon(
        FontAwesomeIcons.addressCard,
        size: 50,
        color: Colors.white,
      ),
    );
  }

  Widget CardProfile(){
    return Card(
      color: Colors.blue,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            profile(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          color: Colors.white,
          child: Column(
            children: [
              CardProfile(),
              SizedBox(height: 15,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                          "Form Absensi",
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    )
                  ],
                )
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Text(time,
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.grey
                    ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}