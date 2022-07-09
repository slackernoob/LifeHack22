import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 10.0,
          ),
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "A Map",
//           ),
//           backgroundColor: Colors.green,
//         ),
//         body: GoogleMap(
//           initialCameraPosition: initialCameraPosition,
//           // markers: markersList,
//           // polylines: _polylines,
//           mapType: MapType.normal,
//           onMapCreated: (GoogleMapController controller) {
//             googleMapController = controller;
//           },
//           // myLocationEnabled: true,
//           // padding:
//           //     EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
//         ));
//   }
// }

