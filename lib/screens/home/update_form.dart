import 'package:flutter/material.dart';
import 'package:small_talk/shared/constants.dart';

class UpdateForm extends StatefulWidget {
  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final _formKey = GlobalKey<FormState>();

  String _currentUsername;
  String _currentBio;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 30.0),
          Text(
            "Update your Profile",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.red[900],
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: "Username"),
            validator: (val) => val.isEmpty ? "Please enter a username" : null,
            onChanged: (val) => setState(() => _currentUsername = val),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: "Short personal bio"),
            validator: (val) => val.isEmpty ? "Please enter a bio" : null,
            onChanged: (val) => setState(() => _currentBio = val),
          ),
          SizedBox(height: 50.0),
          RaisedButton(
              color: Colors.red[900],
              child: Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                print(_currentUsername);
                print(_currentBio);
              }),
        ],
      ),
    );
  }
}
