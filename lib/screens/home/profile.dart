import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:small_talk/screens/home/update_form.dart';
import 'package:small_talk/shared/loading_spin.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String uid;
  dynamic signedInUser;
  bool loading = true;

  void getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user);
    setState(() {
      uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (uid == null) {
      getUser();
    }

    void _showUpdatePanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: UpdateForm(),
            );
          });
    }

    return StreamBuilder(
      stream: Firestore.instance.collection('profile').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoadingSpin();

        return Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                    child: SizedBox(
                      width: 180.0,
                      height: 180.0,
                      child: Image.asset(
                        "assets/avatar.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                snapshot.data.documents[0]['username'],
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                snapshot.data.documents[0]['bio'],
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.0),
              FlatButton.icon(
                label: Text(
                  "",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () => _showUpdatePanel(),
              ),
            ],
          ),
        );
      },
    );
  }
}
