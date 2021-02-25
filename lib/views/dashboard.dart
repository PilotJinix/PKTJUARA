import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pktjuara/helper/api.dart';
import 'package:pktjuara/helper/custom_alert_dialog.dart';
import 'package:pktjuara/helper/getdata.dart';
import 'package:pktjuara/service/world_time.dart';
import 'package:pktjuara/views/mapstry2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class dashboard extends StatefulWidget{


  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  Set<Marker> _marker = HashSet<Marker>();
  // List<Marker> _marker =[];
  Set<Circle> _radius = HashSet<Circle>();
  Set<Polygon> _polygon = HashSet<Polygon>();
  GoogleMapController _mapController;
  Position currentPosition;
  var datapolygon;
  String time ="loading";
  String date ="loading";
  String time_IN ="";
  String time_OUT ="";
  String date_IN ="";
  String date_OUT ="";
  bool visibilyty_IN= true;
  bool visibilyty_OUT= true;
  bool timedecision= true;
  DateTime current;
  File imgcamera;
  double mylat;
  double mylo;

  // String radiuslat = "-8.141719";
  // String radiuslo = "113.726656";

  String radiuslat;
  String radiuslo;

  // //Trying
  // String radiuslat = "-8.1417907";
  // String radiuslo = "113.7260868";
  // //Trying
  String nama = "", npk = "", IdArea="", type_absen;
  String status = "WFO";

  LatLng latlong;
  List areapolygon;
  List<String> dataarea = List<String>();


  void getdata()async{
    var xnama = await GetData.getnama_user();
    var xnpk = await GetData.getnpk();
    setState(() {
      nama = xnama;
      npk = xnpk;
    });
  }

  void getidmarker()async{
    SharedPreferences getdata = await SharedPreferences.getInstance();
    var response = await http.get(Api.area+getdata.getString("npk"));
    List data = json.decode(response.body);
    double range = await countDistance();

    for (int i=0; i<data.length; i++){
      print(latlong);
      print(range);
      if (_checkIfValidMarker(latlong, areapolygon )){
        IdArea = data[i]["id_area"];
      }else if (range <= 0.015){
        IdArea = data[i]["id_area"];
      }else{
        print("Data Tidak Ditemukan!!!!!");
      }
    }
  }

  void setupTime()async{
    WorldTime intance = WorldTime(location: "Bontang", flag: "Indonesia.png", url: "Asia/Kuala_Lumpur");
    await intance.getTime();
    print("Ini Time Decision = $timedecision");
    setState(() {
      if (timedecision){
        print("MASUK TRUE");
        time_IN = intance.time;
        date_IN = intance.date;
        time_OUT = "";
        date_OUT = "";
        absentoserver(1);
        // timedecision = false;
      }else{
        print("MASUK FALSE");
        time_OUT = intance.time;
        date_OUT = intance.date;
        timedecision = true;
        absentoserver(2);
      }
    });
  }

  @override
  void initState(){
    getdata();
    super.initState();
    // _setRadius();
    // _setPoli();
    showareauser();

  }

  Widget header(){
    return ListTile(
      title: Text("SELAMAT DATANG",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget headerlog(){
    return ListTile(
      title: Text("DATA ABSENSI",
        style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget profile(){
    return ListTile(
      title: Text(nama,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold
      ),),
      subtitle: Text(npk,
      style: TextStyle(
        color: Colors.white
      ),),
      leading: FaIcon(
        FontAwesomeIcons.addressCard,
        size: 50,
        color: Colors.white,
      ),
    );
  }

  Widget log(String data, String time, String date){
    return ListTile(
      title: Text(data,
        style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold
        ),),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("- ${time}",
            style: TextStyle(
                color: Colors.blue
            ),),
          Text("  ${date}",
            style: TextStyle(
                color: Colors.blue
            ),),
        ],
      ),
      leading: FaIcon(
        FontAwesomeIcons.addressCard,
        size: 50,
        color: Colors.blue,
      ),
    );
  }

  Widget CardProfile(){
    return Card(
      color: Colors.blue,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            profile(),
          ],
        ),
      ),
    );
  }

  Widget Cardlog(){
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerlog(),
            Center(
              child: Container(
                child: imgcamera==null ? Text(
                  "Tidak ada Bukti",
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ):Image.file(imgcamera, width: 400, height: 320),
              ),
            ),
            log("Clock-In", time_IN, date_IN),
            log("Clock-Out", time_OUT, date_OUT),
          ],
        ),
      ),
    );
  }

  Future<double> countDistance() async {
    Geolocator geolocator = new Geolocator();
    double la = double.parse(radiuslat);
    double lo = double.parse(radiuslo);
    Future<double> distance = geolocator.distanceBetween(la, lo, mylat, mylo);
    double jarak = await distance / double.parse('1000');
    // print("Ini Jarak $jarak");
    return jarak;
  }

  bool _checkIfValidMarker(LatLng tap, List<LatLng> vertices) {
    int intersectCount = 0;
    // print("INI COBA ${vertices.length}");
    for (int j = 0; j < vertices.length - 1; j++) {
      // print("J = $j");
      if (rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }
    // print(intersectCount);

    return ((intersectCount % 2) == 1);
  }

  bool rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    // print("===============");
    // print("aY = $aY");
    // print("bY = $bY");
    // print("aX = $aX");
    // print("bX = $bX");
    // print("pY = $pY");
    // print("pX = $pY");
    // print("===============");


    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false;
    }

    double m = (aY - bY) / (aX - bX);
    double bee = (-aX) * m + aY;
    double x = (pY - bee) / m;

    // print("X = $x");

    return x > pX;
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController _emailControllerField =
          TextEditingController();
          return CustomAlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height /3,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Text(
                    "Peringatan!!!",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 25,),
                  FaIcon(
                    FontAwesomeIcons.map,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 25,),
                  Text(
                    "Anda sekarang tidak berada dalam jangkauan",
                    style: TextStyle(
                        fontWeight: FontWeight.w200
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: RaisedButton(
                        onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>dashboard())),
                        color: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Text(
                          "Dashboard",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white
                          ),
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        });
  }

  void _setRadius(){
    _radius.add(Circle(circleId: CircleId("1"),
        // center: LatLng(-8.141719,113.726656),
        //Trying
        center: LatLng(-8.141719, 113.726656),
        //Trying
        radius: 15,
        strokeWidth: 0,
        fillColor: Color.fromRGBO(52, 116, 235, .3)
    ),
    );
  }

  void _setPoli() async{
    List<LatLng> polygonLatLongs = List<LatLng>();
    // polygonLatLongs.add(LatLng(-8.1415397,113.7260078));
    // polygonLatLongs.add(LatLng(-8.141660, 113.726453));
    // polygonLatLongs.add(LatLng(-8.141787, 113.726356));
    // polygonLatLongs.add(LatLng(-8.141906, 113.726281));
    // polygonLatLongs.add(LatLng(-8.142047, 113.726195));
    // polygonLatLongs.add(LatLng(-8.142387, 113.725940));
    // polygonLatLongs.add(LatLng(-8.142552, 113.726136));
    // polygonLatLongs.add(LatLng(-8.142863, 113.726517));
    // polygonLatLongs.add(LatLng(-8.142618, 113.726742));
    // polygonLatLongs.add(LatLng(-8.142424, 113.726922));
    // polygonLatLongs.add(LatLng(-8.142278, 113.727064));
    // polygonLatLongs.add(LatLng(-8.142145, 113.727166));
    // polygonLatLongs.add(LatLng(-8.141927, 113.726973));
    // polygonLatLongs.add(LatLng(-8.141757, 113.726831));
    // polygonLatLongs.add(LatLng(-8.141677, 113.726739));
    // polygonLatLongs.add(LatLng(-8.141601, 113.726644));
    // polygonLatLongs.add(LatLng(-8.1415397,113.7260078));


    SharedPreferences getdata = await SharedPreferences.getInstance();
    var responsearea = await http.get(Api.area+getdata.getString("npk"));
    List data = json.decode(responsearea.body);
    // print(data);

    setState(() {
      datapolygon = (data[0]["polygon"]);
    });

    List dataplg = datapolygon.split(":");

    for (int i=0; i<dataplg.length;i++){
      List data = dataplg[i].split(",");
      polygonLatLongs.add(LatLng(double.tryParse(data[0]), double.tryParse(data[1])));
    }

    setState(() {
      areapolygon = polygonLatLongs;
    });

    _polygon.add(
      Polygon(
          polygonId:PolygonId("0"),
          points: polygonLatLongs,
          fillColor: Color.fromRGBO(52, 116, 235, .3),
          strokeWidth: 0
      ),
    );

  }

  void _setRadius1(String lat, String lng, var radius){
    var latitude = double.parse(lat);
    var longtitude = double.parse(lng);
    var radiusarea = double.parse(radius);
    setState(() {
      radiuslat = lat;
      radiuslo = lng;
    });
    _radius.add(Circle(circleId: CircleId("1"),
        // center: LatLng(-8.141719,113.726656),
        //Trying
        center: LatLng(latitude, longtitude),
        //Trying
        radius: radiusarea,
        strokeWidth: 0,
        fillColor: Color.fromRGBO(52, 116, 235, .3)
    ),
    );
  }

  void _setPoli1(var datapolygon) async{
    List<LatLng> polygonLatLongs = List<LatLng>();

    setState(() {
      datapolygon = datapolygon;
    });

    List dataplg = datapolygon.split(":");

    for (int i=0; i<dataplg.length;i++){
      List data = dataplg[i].split(",");
      polygonLatLongs.add(LatLng(double.tryParse(data[0]), double.tryParse(data[1])));
    }

    setState(() {
      areapolygon = polygonLatLongs;
    });

    _polygon.add(
      Polygon(
          polygonId:PolygonId("0"),
          points: polygonLatLongs,
          fillColor: Color.fromRGBO(52, 116, 235, .3),
          strokeWidth: 0
      ),
    );

  }

  void _setMarker1(String lat, String lng, var lokasi, var marker_id)async{
    var latitude = double.parse(lat);
    var longtitude = double.parse(lng);
    var markerid = String.fromCharCode(marker_id);
    print(markerid.runtimeType);
    print(latitude);
    print(longtitude);
    // _marker = [];
    _marker.add(
        Marker(
            markerId: MarkerId(markerid),
            // position: LatLng(-8.141719,113.726656),
            //

            position: LatLng(latitude, longtitude),
            //Trying
            infoWindow: InfoWindow(title: lokasi)
        )
    );
  }

  void myLocate()async{
    Geolocator geolocator = new Geolocator();
    Position position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;


    //Trying
    LatLng latLng = LatLng(0.186673, 117.478299);
    //Trying


    // LatLng latLng = LatLng(position.latitude, position.longitude);
    setState(() {
      //Trying
      mylat=0.125171;
      mylo=117.492650;
      //Trying


      // mylat = latLng.latitude;
      // mylo = latLng.longitude;
      latlong = latLng;
    });

    CameraPosition cameraPosition = new CameraPosition(target: latLng, zoom: 19);
    _mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }

  void _onMapCreated(GoogleMapController googleMapController){
    _mapController = googleMapController;
    myLocate();

  }

  Widget maps(){
    return Container(
      height: MediaQuery.of(context).size.height/3,
      width: MediaQuery.of(context).size.width-30,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            target: LatLng(-8.1417907, 113.7260868),
            zoom: 17
        ),
        markers: Set.from(_marker),
        circles: _radius,
        polygons: _polygon,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }

  void cek() async{
    double range = await countDistance();

    if (_checkIfValidMarker(latlong, areapolygon ) || range <= 0.015){
      tes();
      showModalBottomSheet(context: context, builder: ((builder) => popup()),);
    }else{
      showAlertDialog(context);
    }
  }

  timer() async{
    var duration = new Duration(seconds: 3);
    return Timer(duration, (){
      setState(() {
        visibilyty_OUT = true;
        // timedecision = false;
      });
    });
  }

  Future viewcamera()async{
    imgcamera = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imgcamera=imgcamera;
      tes();
    });
  }

  Future<bool> pop(){
    DateTime out = DateTime.now();
    if (current == null || out.difference(current) > Duration(seconds: 2)){
      current = out;
      FlutterToast.showToast(
          msg: "Tekan lagi untuk keluar Aplikasi",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black54
      );
      return Future.value(false);
    }else{
      exit(0);
    }
  }

  Widget popup(){
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Pilih Perangkat Anda",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: viewcamera,
                icon: Icon(
                    Icons.camera
                ),
                label: Text(
                    "Kamera"
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<bool> tes(){
    if (imgcamera==null){
    }else{
      print("Ini Time Decision = $timedecision");
      setupTime();
      timer();
    }
  }

  void showareauser()async{
    SharedPreferences getdata = await SharedPreferences.getInstance();
    var responsearea = await http.get(Api.area+getdata.getString("npk"));
    List data = json.decode(responsearea.body);

    for(int i = 0; i < data.length; i++ ){
      if (data[i]["type_map"]=="polygon"){
        _setPoli1(data[i]["polygon"]);
        _setMarker1(data[i]["lat"], data[i]["lng"], data[i]["nama_area"], i);
      }else{
        _setRadius1(data[i]["lat"], data[i]["lng"], data[i]["radius"]);
        _setMarker1(data[i]["lat"], data[i]["lng"], data[i]["nama_area"], i);
      }
    }
  }

  void absentoserver(var type)async{
    SharedPreferences getdata = await SharedPreferences.getInstance();
    var dataabsen = new Map<String, dynamic>();
    print(IdArea.runtimeType);
    print(getdata.getString("npk").runtimeType);
    print(type.runtimeType);
    print(mylat.runtimeType);
    print(mylo.runtimeType);
    print(getdata.getString("is_organik").runtimeType);
    print(imgcamera.toString());
    dataabsen["id_area"] = IdArea.toString();
    dataabsen["npk"] = getdata.getString("npk");
    dataabsen["type"] =type.toString();
    dataabsen["lat"] =mylat.toString();
    dataabsen["lng"] =mylo.toString();
    dataabsen["status_karyawan"] = getdata.getString("is_organik");
    dataabsen["file"] = imgcamera.toString();

    var response = await http.post(Api.clockinout,  body:dataabsen, headers: {
      'Accept':'application/json'
    });
    print(response.body);

  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>pop(),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: ListView(
            children: [
              CardProfile(),
              SizedBox(height: 15,),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                          "Form Absensi",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                      )
                    ],
                  )
              ),
              SizedBox(height: 20,),
              Center(
                child: Stack(
                  children: [
                    maps(),
                    Positioned(
                      top: 15,
                      left: 14,
                      child: GestureDetector(
                        onTap: ()=> Navigator.push(context , MaterialPageRoute(builder: (context) => GoogleMaps())),
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            // shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.blue,
                          ),
                          child: Icon(
                            Icons.map,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: visibilyty_IN,
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: RaisedButton(
                        onPressed: () {
                          getidmarker();
                          setState(() {
                            imgcamera = null;
                            time_IN = "";
                            date_IN = "";
                            time_OUT = "";
                            date_OUT = "";
                            timedecision = true;
                          });
                          myLocate();
                          cek();

                          // timer();
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>dashboard()));
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: MediaQuery.of(context).size.width/3,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: new LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 64, 255, 115),
                                    Color.fromARGB(255, 48, 191, 86)
                                  ]
                              )
                          ),
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            "CLOCK-IN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visibilyty_OUT,
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: RaisedButton(
                        onPressed: () {
                          getidmarker();
                          // setupTime();
                          setState(() {
                            imgcamera = null;
                            timedecision = false;
                          });
                          myLocate();
                          cek();
                          // showAlertDialog(context);
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: MediaQuery.of(context).size.width/3,
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: new LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 255, 0, 0),
                                    Color.fromARGB(255, 255, 48, 48)
                                  ]
                              )
                          ),
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            "CLOCK-OUT",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ) ,
                  ),
                ],
              ),
              Cardlog(),
            ],
          ),
        ),
      ),
    );
  }
}