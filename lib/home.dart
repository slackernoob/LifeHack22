import 'package:flutter/material.dart';
import 'package:lifehack_app/addpost.dart';
import 'package:lifehack_app/displayphotos.dart';
import 'package:lifehack_app/imageupload.dart';
import 'package:lifehack_app/map.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text('Home'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(1.0), BlendMode.modulate),
              image: AssetImage("lib/assets/E-Waste-Image.jpg"),
              fit: BoxFit.cover),
        ),
      ),
      floatingActionButton: SpeedDial(
        activeBackgroundColor: Colors.green[400],
        backgroundColor: Colors.green[400],
        activeIcon: Icons.cancel,
        icon: Icons.more_vert,
        children: [
          SpeedDialChild(
            label: "Upload image for points",
            child: const Icon(Icons.upload),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ImageUpload(),
                ),
              );
            },
          ),
          SpeedDialChild(
            label: "Map to locate e-bins",
            child: const Icon(Icons.map),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Map(),
                ),
              );
            },
          ),
          SpeedDialChild(
            label: "View posts uploaded",
            child: const Icon(Icons.post_add_sharp),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DisplayPhotos(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
