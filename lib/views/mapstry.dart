import 'package:flutter/material.dart';
import 'package:pktjuara/helper/getdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tesdata extends StatefulWidget{
  @override
  _TesdataState createState() => _TesdataState();
}

class _TesdataState extends State<Tesdata> {
  String id_user = "", nama = "", npk = "";
  void getdata()async{
    var xid_user = await GetData.getiduser();
    var xnama = await GetData.getnama_user();
    var xnpk = await GetData.getnpk();
    print(xid_user);
    setState(() {
      id_user = xid_user;
      nama = xnama;
      npk = xnpk;
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              id_user
            ),
            Text(
                nama
            ),
            Text(
                npk
            ),
          ],
        ),
      ),
    );
  }
}