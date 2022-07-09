import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

import 'package:http/http.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(1.3521, 103.8198);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<List<dynamic>> _data = [];

  // This function is triggered when the floating button is pressed
  void _loadCSV() async {
    final _rawData =
        await rootBundle.loadString("lib/assets/e-waste-clean.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    // setState() {
    //   _data = _listData;
    // }
    _data = _listData;
    addMarkers(_data);
    setState(() {});
    // print(_listData.length);
  }

  Set<Marker> markerList = {};

  void addMarkers(List<List<dynamic>> data) async {
    for (int i = 1; i < data.length; i++) {
      await convertPostal(data[i][5]);
      print(lat);
      print("_____");
      print(lng);
      markerList.add(Marker(
        markerId: MarkerId(i.toString()),
        position: LatLng(lat, lng), //position of marker
        infoWindow: InfoWindow(
          title: data[i][1], //'Marker Title Second ',
          snippet: data[i][2],
        ),
        onTap: () {}, //show directions from user
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ));
    }
    print('testing loop');
    setState(() {});
  }

  // late LatLng currLatLng;
  late var lat;
  late var lng;

  Future<void> convertPostal(String postal) async {
    Response data = await get(
      Uri.parse(
          "https://developers.onemap.sg/commonapi/search?searchVal=$postal&returnGeom=Y&getAddrDetails=N"),
    );
    var locationData = jsonDecode(data.body);
    // currLatLng = LatLng(
    lat = locationData["results"][0]["LATITUDE"];
    lng = locationData["results"][0]["LONGITUDE"];
    print('test');
    print(lat);
    print(lng);
    // );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Select a recycling bin'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 10.0,
          ),
          markers: markerList,
          mapType: MapType.satellite,
          myLocationEnabled: true,
          // mapToolbarEnabled: true,
          // myLocationButtonEnabled: true,
          // zoomControlsEnabled: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _loadCSV,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
