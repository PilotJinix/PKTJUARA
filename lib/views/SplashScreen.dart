import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pktjuara/views/dashboard.dart';


class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void iniState(){
    super.initState();
    splashscreenstar();
  }

  splashscreenstar()async{
    var duration = const Duration(seconds: 4);
    return Timer (duration, (){
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => dashboard()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onTap: ()=> FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF104FE3),
                        Color(0xFF0D6EAA),
                        Color(0xFF0D6EAA),
                      ],
                  stops: [
                    0.1,1,1
                  ])
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}