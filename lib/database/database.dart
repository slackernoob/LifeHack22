import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifehack_app/database/authentication.dart';
import 'package:lifehack_app/model/user.dart' as model;

class Database {
  // private database usage
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late final String uid = Authentication().currUser.uid;
  late final CollectionReference userRef = _db.collection('users');

  Future createUserDoc(String email) async {
    model.User user = model.User(email: email, uid: uid, points: 0);
    return await userRef.doc(uid).set(user.toJson());
  }
}
