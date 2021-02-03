import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Authentication with ChangeNotifier{

  final String baseurl = '';
  Future<void> logIn(String email, String password) async{
    final response = http.post("$baseurl/")

  }

}