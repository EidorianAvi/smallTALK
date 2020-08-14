import 'package:flutter/material.dart';
import 'package:small_talk/services/auth.dart';
import 'package:small_talk/shared/constants.dart';
import 'package:small_talk/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                "User Registration",
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
                    'Login',
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
                  image: AssetImage('assets/signin.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 65.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 60.0),
                    TextFormField(
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
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.white,
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.red[900],
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = "Invalid Credentials";
                              loading = false;
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
