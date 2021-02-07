import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget{
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {

  Set<Marker> _marker = HashSet<Marker>();
  GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController googleMapController){
    _mapController = googleMapController;

    setState(() {
      _marker.add(
        Marker(
          markerId: MarkerId("0"),
          position: LatLng(-8.1417907, 113.7260868),
          infoWindow: InfoWindow(title: "Lokasi Absen")
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(-8.141719, 113.726656),
        zoom: 15
      ),
        markers: _marker,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}