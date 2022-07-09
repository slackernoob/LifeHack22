import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifehack_app/constants/constant.dart';
import 'package:lifehack_app/database/authentication.dart';
import 'package:lifehack_app/database/database.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool loading = false;
  final Authentication _auth = Authentication();
  final Database _db = Database();
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String errorMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent[400],
          title: const Text('Register to use the app'),
          centerTitle: true,
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 300),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            (value!.isEmpty) ? 'Kindly enter your email' : null,
                        onChanged: (value) {
                          email = value.toString().trim();
                        },
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                          filled: true,
                          fillColor: Colors.white60,
                          hintText: 'Enter your email',
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Password";
                          }
                        },
                        onChanged: (value) {
                          password = value;
                        },
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                          filled: true,
                          fillColor: Colors.white60,
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(
                            Icons.key,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        child: const Text(
                          'Create an account',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          // Check if form is valid.
                          if (formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            try {
                              User user = await _auth.register(email, password);
                              await _db.createUserDoc(email);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.blueGrey,
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        'Sucessfully registered. You can login now'),
                                  ),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                              Navigator.of(context).pop();

                              setState(() {
                                loading = false;
                              });
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                loading = false;
                                errorMsg = e.message!;
                              });
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        errorMsg,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
