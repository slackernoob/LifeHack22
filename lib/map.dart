import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';

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
    // print('i was here');
    final _rawData =
        await rootBundle.loadString("lib/assets/e-waste-clean.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    // setState() {
    //   _data = _listData;
    // }

    _data = _listData;
    print(_data);
    // _data = _listData;
    addMarkers(_data);
    // print(_listData.length);
  }

  Set<Marker> markerList = {};

  void addMarkers(List<List<dynamic>> _data) async {
    for (int i = 1; i < _data.length; i++) {
      // await convertPostal(_data[i][4].toString(), i);

      if (_data[i].length >= 9) {
        markerList.add(Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(_data[i][_data[i].length - 2],
              _data[i][_data[i].length - 1]), //position of marker
          infoWindow: InfoWindow(
            title: _data[i][1], //'Marker Title Second ',
            snippet: _data[i][2],
          ),
          onTap: () {}, //show directions from user
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ));
      }
    }
    setState(() {});
  }

  Future<void> convertPostal(String postal, int index) async {
    if (postal.length != 6) {
      return;
    }

    Response data = await get(
      Uri.parse(
          // "https://developers.onemap.sg/commonapi/search?searchVal=637350&returnGeom=Y&getAddrDetails=N"),
          "https://developers.onemap.sg/commonapi/search?searchVal=$postal&returnGeom=Y&getAddrDetails=N"),
    );
    var locationData = jsonDecode(data.body);
    // print(locationData);
    // currLatLng = LatLng(
    if (locationData["results"].length == 0) {
      return;
    }

    _data[index].add(locationData["results"][0]["LATITUDE"]);
    _data[index].add(locationData["results"][0]["LONGITUDE"]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Select a recycling bin'),
          backgroundColor: Colors.green[400],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
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
          zoomControlsEnabled: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[400],
          onPressed: () => _loadCSV(),
          child: const Icon(Icons.gps_fixed),
        ),
      ),
    );
  }
}
