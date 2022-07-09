import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text(
          "Recycling101",
          style: TextStyle(color: Colors.deepOrange),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              child: TextField(
                keyboardType: TextInputType.number,
              ),
              color: Colors.red,
            ),
            Card(
              child: const Text("Hello world"),
            ),
            Card(),
          ],
        ),
      ),
    );
  }
}
