import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pktjuara/helper/getdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget{
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String nickname = "-", npk = "-", unitkerja = "-", email = "-", last_login = "-";

  @override
  void initState(){
    super.initState();
    data();
  }

  void data()async{
    SharedPreferences getdata = await SharedPreferences.getInstance();
    setState(() {
      nickname = getdata.getString("nickname");
      npk = getdata.getString("npk");
      unitkerja = getdata.getString("unitkerja");
      email = getdata.getString("email");
      last_login = getdata.getString("last_login");
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: size.height/3.3,
            width: size.width,
            decoration: BoxDecoration(
              color: Color(0xFF004487),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: CircleAvatar(
                      radius: 55,
                      child: FadeInImage.assetNetwork(
                          placeholder: "assets/avatar.png",
                          image: "https://juara.pupukkaltim.com/image/avatar.png"
                      )
                  ),
                ),
                Text(
                  "Muahmmad Agung Santoso",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500

                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.idBadge,
              size: 30,
            ),
            title: Text(
              "Nickname",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12
              ),
            ),
            subtitle: Text(
              nickname,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),

          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.idCard,
              size: 30,
            ),
            title: Text(
              "NPK",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12
              ),
            ),
            subtitle: Text(
              npk,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),
            ),

          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.briefcase,
              size: 30,
            ),
            title: Text(
              "Unit Kerja",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12
              ),
            ),
            subtitle: Text(
              unitkerja,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),
            ),

          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.envelope,
              size: 30,
            ),
            title: Text(
              "Email",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12
              ),
            ),
            subtitle: Text(
              email,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),
            ),

          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.history,
              size: 30,
            ),
            title: Text(
              "Last Login",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12
              ),
            ),
            subtitle: Text(
              last_login,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),
            ),

          ),
        ],
      ),

    );
  }
}