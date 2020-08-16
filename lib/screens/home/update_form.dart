import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/models/user.dart';
import 'package:small_talk/services/database.dart';
import 'package:small_talk/shared/constants.dart';
import 'package:small_talk/shared/loading_spin.dart';
import 'package:path/path.dart';

class UpdateForm extends StatefulWidget {
  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  String _currentUsername;
  String _currentBio;
  String _currentImageUrl;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
    }

    Future uploadPhoto() async {
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      print(firebaseStorageRef.getDownloadURL().toString());
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      if (taskSnapshot.error == null) {
        final String downloadUrl =
        await taskSnapshot.ref.getDownloadURL();
        setState(() {
          _currentImageUrl = downloadUrl;
        });
      }
    }

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoadingSpin();
        UserData userData = snapshot.data;
        return Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                "Update your Profile",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.red[900],
                ),
              ),
              SizedBox(height: 25.0),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                  child: SizedBox(
                    width: 60.0,
                    height: 60.0,
                    child: _image != null
                    ? Image.file( _image, fit: BoxFit.fill ) : Image.asset(
                      "assets/avatar.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              FlatButton.icon(
                onPressed: () {
                  getImage();
                },
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[900],
                ),
                label: Text('Upload Image'),
              ),
              SizedBox(height: 20.0),
             TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Username"),
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
                    await uploadPhoto();
                    if(_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserProfile(
                          userData.email,
                          _currentUsername ?? userData.username,
                          _currentBio ?? userData.bio,
                          _currentImageUrl ?? userData.image,
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
