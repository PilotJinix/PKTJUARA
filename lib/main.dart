import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:pktjuara/controllers/authentication.dart';
import 'package:pktjuara/views/SplashScreens.dart';
import 'package:provider/provider.dart';

void main() {
  SdkContext.init(IsolateOrigin.main);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PKT JUARA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
