import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:pktjuara/views/SplashScreens.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:pktjuara/helper/api.dart';
import 'package:http/http.dart' as http;
import 'package:pktjuara/views/dashboard.dart';
import 'package:flutter/services.dart';
import 'package:pktjuara/views/saving_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterBackgroundService.initialize(dataonStart);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PKT JUARA',
      theme: ThemeData(
        primaryColor: Color(0xFF004487),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}

