import 'package:flutter/material.dart';
import 'package:small_talk/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Sign In "),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: RaisedButton(
          child: Text("Sign in Anon"),
          onPressed: () async {
            dynamic result = await _auth.signInAnon();
            if (result == null) {
              print("Error signing in");
            } else {
              print("Signed In");
              print(result.uid);
            }
          },
        ),
      ),
    );
  }
}
