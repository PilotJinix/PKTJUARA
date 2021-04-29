import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitCubeGrid(
          color: Color(0xFF004487),
          size: 20,
        ),
      ),
    );
  }
}