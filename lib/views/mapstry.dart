import 'package:flutter/material.dart';

class Tesdata extends StatefulWidget{
  @override
  _TesdataState createState() => _TesdataState();
}

class _TesdataState extends State<Tesdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "hello"
            )
          ],
        ),
      ),
    );
  }
}