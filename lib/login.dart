import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifehack_app/database/authentication.dart';
import 'package:lifehack_app/database/database.dart';
import 'package:lifehack_app/home.dart';
import 'package:lifehack_app/register.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  static const String _title = 'Recycling101';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.greenAccent[400],
            title: const Text(_title)),
        body: const LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Authentication _auth = Authentication();
  final Database _db = Database();
  String errorMsg = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: const Icon(
            Icons.compost,
            color: Colors.lightGreenAccent,
            size: 48.0,
            semanticLabel: 'Recycle',
          )),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: const Text(
          'Sign in',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        child: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email Address',
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: TextField(
          obscureText: true,
          controller: passwordController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),
        ),
      ),
      Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ElevatedButton(
            onPressed: () async {
              try {
                await _auth.signIn(
                    nameController.text, passwordController.text);
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              } on FirebaseAuthException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.blueGrey,
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('$e'),
                    ),
                    duration: Duration(seconds: 5),
                  ),
                );
              }
              print(nameController.text);
              print(passwordController.text);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.greenAccent[400],
              // textStyle: const TextStyle(
              //   fontWeight: FontWeight.bold,
              // ),
            ),
            child: const Text('Login')),
      ),
      Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: OutlinedButton(
            child: const Text('Forgot Password'),
            onPressed: () {
              print(nameController.text);
              print(passwordController.text);
            },
          )),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Not registered yet?'),
          TextButton(
              onPressed: () {
                //register screen
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Register()));
              },
              child: const Text(
                'Sign up now',
                style: TextStyle(fontSize: 16),
              ))
        ],
      )
    ]));
  }
}
