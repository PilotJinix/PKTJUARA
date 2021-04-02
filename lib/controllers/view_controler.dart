import 'package:flutter/material.dart';
import 'package:pktjuara/views/dashboard.dart';
import 'package:pktjuara/views/mapstry2.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int current = 0;
  final List<Widget> screens =[
    Dashboard(),
    GoogleMaps()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}