import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:pktjuara/service/world_time.dart';
import 'package:pktjuara/views/mapstry2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class dashboard extends StatefulWidget{


  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  Set<Marker> _marker = HashSet<Marker>();
  Set<Circle> _radius = HashSet<Circle>();
  GoogleMapController _mapController;
  Position currentPosition;
  String time ="loading";



  void setupTime()async{
    WorldTime intance = WorldTime(location: "Bontang", flag: "Indonesia.png", url: "Asia/Kuala_Lumpur");
    await intance.getTime();
    print(intance.time);
    print(intance.location);
    setState(() {
      time = intance.time;
    });
  }

  @override
  void initState(){
    super.initState();
    setupTime();
    _setRadius();
  }

  Widget header(){
    return ListTile(
      title: Text("SELAMAT DATANG",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
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

  void _setRadius(){
    _radius.add(Circle(circleId: CircleId("1"),
        center: LatLng(-8.1417907, 113.7260868),
        radius: 10,
        strokeWidth: 0,
        fillColor: Color.fromRGBO(52, 116, 235, .3)
    )
    );
  }

  void myLocate()async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLng = LatLng(position.latitude, position.longitude);
    print(latLng);
    CameraPosition cameraPosition = new CameraPosition(target: latLng, zoom: 19);
    _mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }

  void _onMapCreated(GoogleMapController googleMapController){
    _mapController = googleMapController;


    setState((){
      _marker.add(
          Marker(
              markerId: MarkerId("0"),
              position: LatLng(-8.1417907, 113.7260868),
              infoWindow: InfoWindow(title: "Lokasi Absen")
          )
      );
    });
  }

  Widget maps(){
    return Container(
      height: MediaQuery.of(context).size.height/3,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            target: LatLng(-8.1417907, 113.7260868),
            zoom: 17
        ),
        markers: _marker,
        circles: _radius,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: ListView(
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
            SizedBox(height: 20,),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 20),
            //   child: Column(
            //     children: [
            //       Text(time,
            //         style: TextStyle(
            //             fontSize: 50,
            //             color: Colors.grey
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Center(
              child: Stack(
                children: [
                  maps(),
                  Positioned(
                    top: 15,
                    left: 14,
                    child: GestureDetector(
                      onTap: ()=> Navigator.push(context , MaterialPageRoute(builder: (context) => GoogleMaps())),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.blue,
                        ),
                        child: Icon(
                          Icons.map,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      //     color: Colors.white,
      //     child: Column(
      //
      //     ),
      //   ),
      // )
    );
  }
}