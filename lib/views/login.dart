import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:pktjuara/controllers/authentication.dart';
import 'package:pktjuara/helper/api.dart';
import 'package:pktjuara/helper/logincolor.dart';
import 'package:pktjuara/views/dashboard.dart';
import 'package:pktjuara/views/mapstry.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController npk = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();


  Future log()async{

    var data = new Map<String, dynamic>();
    data["npk"] = npk.text;
    data["password"] = password.text;
    print(data);
    var response = await http.post("http://e1c709dae5ac.ngrok.io/api/login", body:data, headers: {
      'Accept':'application/json'
    });
    print(response.statusCode);
    print(response.headers);
    if (response.statusCode==200){
      CoolAlert.show(context: context, type: CoolAlertType.loading);
      var duration = new Duration(seconds: 3);
      Timer(duration, (){
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return dashboard();
            },
            transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return Align(
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 200),
          ),
        );
      });
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>dashboard()));

    }else{

      CoolAlert.show(context: context, type: CoolAlertType.error, text: "NPK atau Passwrod anda salah", title: "Terjadi Kesalahan");
    }

  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginColor(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Masuk",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D6EAA),
                        fontSize: 25
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: npk,
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return 'invalid Email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Email"
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: password,
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return 'invalid Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Kata Sandi"
                    ),
                    obscureText: true,
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Maps()));
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: Text(
                      "Lupa Kata Sandi?",
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0XFF2661FA)
                      ),
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.05),

                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: RaisedButton(
                    onPressed: () {
                      log();
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: new LinearGradient(
                              colors: [
                                Color.fromARGB(255, 255, 136, 34),
                                Color.fromARGB(255, 255, 177, 41)
                              ]
                          )
                      ),
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        "MASUK",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      )
    );
  }
}