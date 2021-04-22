import 'package:flutter/material.dart';
import 'package:pktjuara/controllers/view_controler.dart';
import 'package:pktjuara/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication extends StatefulWidget{
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  Future<bool>Session()async{
    SharedPreferences getdata = await SharedPreferences.getInstance();
    var sessioning = getdata.getBool("done");
    if(sessioning==null){
      sessioning = false;
    }
    return sessioning;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: Session(),
        builder: (ctx, AsyncSnapshot<bool> snapshot){
          if (snapshot.connectionState == ConnectionState.done && snapshot.data == true){
            return Home();
          }else{
            return LoginPage();
          }
        }
      ),
    );
  }
}