import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/models/user.dart';
import 'package:small_talk/services/database.dart';
import 'package:small_talk/shared/constants.dart';
import 'package:small_talk/shared/loading_spin.dart';

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
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoadingSpin();
        UserData userData = snapshot.data;
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
                validator: (val) => val.length > 50  && val.isEmpty ? "Bio must be 50 chars or less" : null,
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
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserProfile(
                          _currentUsername ?? userData.username,
                          _currentBio ?? userData.bio,
                          userData.image,
                          userData.uid,
                      );
                      Navigator.pop(context);
                    }
                  },
              ),
            ],
          ),
        );
      }
    );
  }
}
