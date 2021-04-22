import 'package:flutter/material.dart';
import 'package:pktjuara/controllers/authentication.dart';
import 'dart:async';
import 'package:pktjuara/views/dashboard.dart';
import 'package:pktjuara/views/login.dart';

class SplashScreen extends StatefulWidget{
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen>{

  void initState(){
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async{
    var duration = const Duration(seconds: 4);
    return Timer(duration, (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Authentication()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF0D6EAA),
                        Color(0xFFffffff),
                        Color(0xFFffffff),
                        Color(0xFF0D6EAA),
                      ],
                      stops: [
                        0.1,0.5,0.5,1
                      ])
              ),
            ),
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset("assets/jasa desain logo bagus.png",
                        height: 50,),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}