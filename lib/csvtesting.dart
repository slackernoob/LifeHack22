import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:csv/csv.dart';

class csv extends StatefulWidget {
  const csv({Key? key}) : super(key: key);

  @override
  State<csv> createState() => _csvState();
}

class _csvState extends State<csv> {
  List<List<dynamic>> _data = [];

  // This function is triggered when the floating button is pressed
  void _loadCSV() async {
    final _rawData =
        await rootBundle.loadString("lib/assets/e-waste-clean.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    setState(() {
      _data = _listData;
    });
    print(_listData);
    print(_listData[1][0]);
    print(_listData[1][1]);
    print(_listData[1][2]);
    print(_listData[1][3]);
    print(_listData[1][4]);
    // for (int i = 0; i < _listData.length; i = i + 1) {
    //   print(_data[i][0]);
    //   print(_data[i][1]);
    //   print(_data[i][2]);
    //   print(_data[i][3]);
    //   print(_data[i][4]);
    //   print("______________");
    // }
    // print(_listData);
    // print(_data[0][0].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kindacode.com"),
      ),
      // Display the contents from the CSV file
      // body: ListView.builder(
      //   itemCount: _data.length,
      //   itemBuilder: (_, index) {
      //     return Card(
      //       margin: const EdgeInsets.all(3),
      //       color: index == 0 ? Colors.amber : Colors.white,
      //       child: ListTile(
      //         leading: Text(_data[index][0].toString()),
      //         title: Text(_data[index][1]),
      //         trailing: Text(_data[index][2].toString()),
      //       ),
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add), onPressed: _loadCSV),
    );
  }
}
