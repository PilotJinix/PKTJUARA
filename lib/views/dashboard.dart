import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dashboard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.blue),
        elevation: 0.0,
        backgroundColor: Colors.blue.withOpacity(0),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "PKT JUARA",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
            child: Text(
              "Saham Usaha Kecil Menengah",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 160),
            child: Text(
              "Copyright 2020 Sahum, by Muhammad Agung Santoso",
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          )

        ],
      ),
    );
  }

}