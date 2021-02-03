import 'package:flutter/material.dart';
import 'package:pktjuara/controllers/authentication.dart';
import 'package:pktjuara/views/SplashScreens.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Authentication())

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PKT JUARA',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),

    );
  }
}
