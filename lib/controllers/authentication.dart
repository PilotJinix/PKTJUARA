

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pktjuara/controllers/convert.dart';
import 'dart:convert';
import 'package:pktjuara/views/dashboard.dart';

class Authentication with ChangeNotifier{

  final String baseurl = '';
  Future<void> logIn(String npk, String password) async{

  }

  Future<void> logInfirebase(String email, String password) async{

    const url ="https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA3q0uZa2ictowFmQBlxDyGDeFcOzu6F1Y";

    try{
      final response = await http.post(url, body: json.encode(
          {
            "email" : email,
            "password" : password,
            "returnSecureToken" : true,
          }
      ));
      final responseData = json.decode(response.body);
      print(responseData);
      if(responseData['error'] != null)
      {
        throw Convert(responseData['error']['message']);
      }

    } catch (error)
    {
      throw error;
    }

  }
}