import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifehack_app/database/authentication.dart';
import 'package:lifehack_app/model/post.dart';
import 'package:lifehack_app/model/user.dart' as model;
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Database {
  // private database usage
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Authentication _auth = Authentication();
  late final String uid = Authentication().currUser.uid;
  late final CollectionReference userRef = _db.collection('users');

  Future createUserDoc(String email) async {
    model.User user = model.User(email: email, uid: uid, points: 0);
    return await userRef.doc(uid).set(user.toJson());
  }

  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // creating location to our firebase storage
    Reference ref = _storage.ref().child(childName).child(_auth.currUser.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> uploadPost(Uint8List file, String uid) async {
    String res = "Some error occurred";
    try {
      String photoUrl = await uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(
        postUrl: photoUrl,
        isVerified: false,
      );
      _db.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
