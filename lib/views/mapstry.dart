import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tesdata extends StatefulWidget{
  @override
  _TesdataState createState() => _TesdataState();
}

class _TesdataState extends State<Tesdata> {

  Future getdata()async{
    var get = await SharedPreferences.getInstance();
    var iduser = get.getString("id_user");
  }
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