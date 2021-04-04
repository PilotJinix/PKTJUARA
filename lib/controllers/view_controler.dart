import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pktjuara/helper/getdata.dart';
import 'package:pktjuara/views/dashboard.dart';
import 'package:pktjuara/views/mapstry2.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String nama = "", npk = "",avatar="https://juara.pupukkaltim.com/image/avatar.png", unitkerja;
  int current = 0;
  final List<Widget> screens =[
    Dashboard(),
    GoogleMaps()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  void initState(){
    super.initState();
    getdata();
  }

  void getdata()async{
    var xnama = await GetData.getnama_user();
    var xnpk = await GetData.getnpk();
    var xavatar = await GetData.getavatar();
    var xunitkerja = await GetData.getunitkerja();
    print(xavatar);
    setState(() {
      nama = xnama;
      npk = xnpk;
      avatar = xavatar;
      unitkerja = xunitkerja;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF004487),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(nama),
              accountEmail: Text(npk + " - " + unitkerja.toString()),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(avatar),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Kantor_Utama_PT_Pupuk_Kaltim_Bontang.png"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Color(0xFF004487).withOpacity(1), BlendMode.hardLight),
                ),
              ),
            ),
            ListTile(
                leading: Builder(
                  builder: (BuildContext){
                    return FaIcon(
                      FontAwesomeIcons.user,
                      color: Colors.black,
                    );
                  },
                ),
                title: Text(
                  "Profil User",
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
                onTap: ()=> {}
            ),
            ListTile(
                leading: Builder(
                  builder: (BuildContext){
                    return FaIcon(
                      FontAwesomeIcons.qrcode,
                      color: Colors.black,
                    );
                  },
                ),
                title: Text(
                  "Kode Juara",
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
                onTap: ()=> {}
            ),
            ListTile(
                leading: Builder(
                  builder: (BuildContext){
                    return FaIcon(
                      FontAwesomeIcons.stopwatch,
                      color: Colors.black,
                    );
                  },
                ),
                title: Text(
                  "Working Time",
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
                onTap: ()=> {}
            ),
            ListTile(
                leading: Builder(
                  builder: (BuildContext){
                    return FaIcon(
                      FontAwesomeIcons.powerOff,
                      color: Colors.black,
                    );
                  },
                ),
                title: Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 15
                  ),
                ),
                onTap: ()=> {
                  print("Out")
                }
            ),
          ],
        ),
      ),
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        child: FaIcon(
          FontAwesomeIcons.qrcode
        ),
        onPressed: (){
          print("Code");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 80,
                    onPressed: (){
                      setState(() {
                        currentScreen = Dashboard();
                        current = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.home,
                          color: current == 0 ? Color(0xFF004487) : Colors.grey,
                        ),
                        Text(
                          "Dashboard",
                          style: TextStyle(
                              color: current == 0 ? Color(0xFF004487) : Colors.grey,
                              fontWeight: FontWeight.w300,
                            fontSize: 12
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 80,
                    onPressed: (){
                      setState(() {
                        currentScreen = GoogleMaps();
                        current = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.map,
                          color: current == 1 ? Color(0xFF004487) : Colors.grey,
                        ),
                        Text(
                          "Maps",
                          style: TextStyle(
                              color: current == 1 ? Color(0xFF004487) : Colors.grey,
                              fontWeight: FontWeight.w300,
                            fontSize: 12
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 80,
                    onPressed: (){
                      setState(() {
                        currentScreen = Dashboard();
                        current = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.home,
                          color: current == 0 ? Color(0xFF004487) : Colors.grey,
                        ),
                        Text(
                          "Dashboard",
                          style: TextStyle(
                              color: current == 0 ? Color(0xFF004487) : Colors.grey,
                              fontWeight: FontWeight.w300,
                              fontSize: 12
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 80,
                    onPressed: (){
                      setState(() {
                        currentScreen = GoogleMaps();
                        current = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.map,
                          color: current == 1 ? Color(0xFF004487) : Colors.grey,
                        ),
                        Text(
                          "Maps",
                          style: TextStyle(
                              color: current == 1 ? Color(0xFF004487) : Colors.grey,
                              fontWeight: FontWeight.w300,
                              fontSize: 12
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}