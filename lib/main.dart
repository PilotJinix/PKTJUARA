import 'package:flutter/material.dart';
import 'package:pktjuara/views/SplashScreens.dart';
import 'dart:async';
import 'package:pktjuara/views/dashboard.dart';

void main() {
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

// class SplashScreen extends StatefulWidget{
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   void iniState(){
//     super.initState();
//     splashscreenstar();
//   }
//
//   splashscreenstar()async{
//     var duration = const Duration(seconds: 1);
//     return Timer (duration, (){
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => dashboard()),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: GestureDetector(
//           onTap: ()=> FocusScope.of(context).unfocus(),
//           child: Stack(
//             children: [
//               Container(
//                 height: double.infinity,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           Color(0xFF0D6EAA),
//                           Color(0xFFffffff),
//                           Color(0xFFffffff),
//                           Color(0xFF0D6EAA),
//                         ],
//                         stops: [
//                           0.1,0.5,0.5,1
//                         ])
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         child: Image.asset("assets/jasa desain logo bagus.png",
//                         height: 50,),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }