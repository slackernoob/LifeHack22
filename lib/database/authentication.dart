import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User get currUser {
    // enforce non null because current user is never null
    return _auth.currentUser!;
  }

  // User signs in with email and password
  Future signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // debug
      print('$user has signed in');
      return user;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // User registers with email and password
  Future register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // debug
      print('$user registered successfully');
      return user;
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  // User sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
