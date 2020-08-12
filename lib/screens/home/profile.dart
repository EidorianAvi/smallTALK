import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/models/user_profile.dart';
import 'package:small_talk/shared/loading.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String uid;
  dynamic signedInUser;

  // Future<String>
  void getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    uid = user.uid;
  }

  @override
  Widget build(BuildContext context) {
    if (uid == null) {
      getUser();
    }
    // print(uid);
    final profiles = Provider.of<List<UserProfile>>(context);
    if (profiles != null) {
      final dynamic signedInUser = profiles.where((profile) {
        return profile.id == uid;
      });
    }

    if (signedInUser == null) {
      return Loading();
    } else {
      return Container(
        child: Text("Profile"),
      );
    }
  }
}
