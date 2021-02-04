import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:pktjuara/controllers/authentication.dart';
import 'package:pktjuara/helper/api.dart';
import 'package:pktjuara/helper/logincolor.dart';
import 'package:pktjuara/views/dashboard.dart';
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

  Map<String, String> _authData = {
    'npk' : '',
    'password' : ''
  };

  Map<String, String> _authDatafirebase = {
    'email' : '',
    'password' : ''
  };

  Future<void> _submit() async
  {
    if(!_formKey.currentState.validate())
    {
      return;
    }
    _formKey.currentState.save();

    try{
      await Provider.of<Authentication>(context, listen: false).logIn(
          _authData['npk'],
          _authData['password']
      );
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>dashboard()));

    } catch(e)
    {
      print("Bawah");
      var errorMessage = 'Authentication Failed. Please try again later.';
      // _showErrorDialog(errorMessage);
    }
  }

  void log()async{

    var data = new Map<String, dynamic>();
    data["npk"] = npk.text;
    data["password"] = password.text;

    final response = await http.post(Api.connections+"login", body:data);
    if (response.statusCode==200){
      CoolAlert.show(context: context, type: CoolAlertType.loading);
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
          transitionDuration: Duration(milliseconds: 3000),
        ),
      );
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>dashboard()));
    }else{

      CoolAlert.show(context: context, type: CoolAlertType.error);
    }

  }

  Future<void> _submitfirebase() async
  {
    if(!_formKey.currentState.validate())
    {
      return;
    }
    _formKey.currentState.save();

    try{
      await Provider.of<Authentication>(context, listen: false).logInfirebase(
          _authData['email'],
          _authData['password']
      );
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>dashboard()));

    } catch(e)
    {
      print("Bawah");
      var errorMessage = 'Authentication Failed. Please try again later.';
      // _showErrorDialog(errorMessage);
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
                    onSaved: (value){
                      _authData["npk"] = value;
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
                    onSaved: (value){
                      _authData["password"] = value;
                    },
                    decoration: InputDecoration(
                        labelText: "Kata Sandi"
                    ),
                    obscureText: true,
                  ),
                ),

                Container(
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