import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pktjuara/views/dashboard.dart';
import 'package:pktjuara/views/mapstry2.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int current = 0;
  final List<Widget> screens =[
    Dashboard(),
    GoogleMaps()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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