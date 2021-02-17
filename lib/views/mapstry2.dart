import 'dart:async';
import 'dart:collection';
import 'dart:ui';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget{
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {

  Set<Marker> _marker = HashSet<Marker>();
  Set<Circle> _radius = HashSet<Circle>();
  GoogleMapController _mapController;
  ReceivePort port = ReceivePort();
  Set<Polygon> _polygon = HashSet<Polygon>();

  Position currentPosition;
  var geolocator = Geolocator();
  List datadata;


  void initState(){
    super.initState();
    _setRadius();
    _setPoli();
    tes();
  }

  bool _checkIfValidMarker(LatLng tap, List<LatLng> vertices) {
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }

    return ((intersectCount % 2) == 1); // odd = inside, even = outside;
  }

  bool rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = tap.latitude;
    double pX = tap.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false; // a and b can't both be above or below pt.y, and a or
      // b must be east of pt.x
    }

    double m = (aY - bY) / (aX - bX); // Rise over run
    double bee = (-aX) * m + aY; // y = mx + b
    double x = (pY - bee) / m; // algebra is neat!

    return x > pX;
  }

  void myLocate()async{
    Geolocator geolocator = new Geolocator();
    Position position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLng = LatLng(position.latitude, position.longitude);
    print(latLng);
    CameraPosition cameraPosition = new CameraPosition(target: latLng, zoom: 19);
    _mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }

  void _setRadius(){
    _radius.add(Circle(circleId: CircleId("1"),
      center: LatLng(-8.1417907, 113.7260868),
      radius: 10,
      strokeWidth: 0,
      fillColor: Color.fromRGBO(52, 116, 235, .3)
    )
    );
  }

  void _setPoli(){
    List<LatLng> polygonLatLongs = List<LatLng>();
    polygonLatLongs.add(LatLng(-8.1415397,113.7260078));
    polygonLatLongs.add(LatLng(-8.141660, 113.726453));
    polygonLatLongs.add(LatLng(-8.141787, 113.726356));
    polygonLatLongs.add(LatLng(-8.141906, 113.726281));
    polygonLatLongs.add(LatLng(-8.142047, 113.726195));
    polygonLatLongs.add(LatLng(-8.142387, 113.725940));
    polygonLatLongs.add(LatLng(-8.142552, 113.726136));
    polygonLatLongs.add(LatLng(-8.142863, 113.726517));
    polygonLatLongs.add(LatLng(-8.142618, 113.726742));
    polygonLatLongs.add(LatLng(-8.142424, 113.726922));
    polygonLatLongs.add(LatLng(-8.142278, 113.727064));
    polygonLatLongs.add(LatLng(-8.142145, 113.727166));
    polygonLatLongs.add(LatLng(-8.141927, 113.726973));
    polygonLatLongs.add(LatLng(-8.141757, 113.726831));
    polygonLatLongs.add(LatLng(-8.141677, 113.726739));
    polygonLatLongs.add(LatLng(-8.141601, 113.726644));
    polygonLatLongs.add(LatLng(-8.1415397,113.7260078));

    setState(() {
      datadata=polygonLatLongs;
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

  void _onMapCreated(GoogleMapController googleMapController){
    _mapController = googleMapController;
    myLocate();
    setState((){
      _marker.add(
        Marker(
          markerId: MarkerId("0"),
          position: LatLng(-8.1417907, 113.7260868),
          infoWindow: InfoWindow(title: "Lokasi Absen")
        )
      );
    });
  }

  void tes(){
    print(datadata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Location"),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(-8.141719, 113.726656),
        zoom: 15
      ),
        markers: _marker,
        circles: _radius,
        polygons: _polygon,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
      ),
    );
  }
}