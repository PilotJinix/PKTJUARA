import 'package:flutter/material.dart';
import 'package:pktjuara/controllers/authentication.dart';
import 'package:pktjuara/helper/logincolor.dart';
import 'package:pktjuara/views/dashboard.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return 'invalid Email';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _authData["email"] = value;
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
                      _submit();
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