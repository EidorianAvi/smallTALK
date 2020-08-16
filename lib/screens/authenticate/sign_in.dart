import 'package:flutter/material.dart';
import 'package:small_talk/services/auth.dart';
import 'package:small_talk/shared/constants.dart';
import 'package:small_talk/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();


  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[400],
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                "Sign In User",
                style: TextStyle(
                  color: Colors.red[900],
                ),
              ),
              elevation: 2.0,
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  label: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.red[900],
                    ),
                  ),
                  icon: Icon(
                    Icons.person_pin,
                    color: Colors.red[900],
                  ),
                ),
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/signin5.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 60.0),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val.isEmpty ? "Please enter an email" : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration:
                          textInputDecoration.copyWith(hintText: "Password"),
                      validator: (val) =>
                          val.length < 6 ? "Must be at least 6 chars" : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        _auth.resetPass(email);
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text("Forgot Password?", style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.white,
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.red[900],
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _auth.signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = "Invalid Credentials";
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
