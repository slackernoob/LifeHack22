import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifehack_app/database/authentication.dart';
import 'package:lifehack_app/database/database.dart';
import 'package:lifehack_app/model/postcard.dart';

class DisplayPhotos extends StatefulWidget {
  const DisplayPhotos({Key? key}) : super(key: key);

  @override
  State<DisplayPhotos> createState() => _DisplayPhotosState();
}

class _DisplayPhotosState extends State<DisplayPhotos> {
  final Database _db = Database();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos uploaded for points'),
        centerTitle: true,
        backgroundColor: Colors.green[400],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(Authentication().currUser.uid)
            .collection('photos')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width * 0.3,
                vertical: 15,
              ),
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
    );
  }
}
