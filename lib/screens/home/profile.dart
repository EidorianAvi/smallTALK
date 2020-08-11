import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/models/user_profile.dart';

class Profile extends StatefulWidget {
  final dynamic auth;
  Profile({this.auth});

  @override
  _ProfileState createState() => _ProfileState(auth: auth);
}

class _ProfileState extends State<Profile> {
  final dynamic auth;
  _ProfileState({this.auth});

  @override
  Widget build(BuildContext context) {
    final profiles = Provider.of<List<UserProfile>>(context);
    // print(profiles);
    // print(auth);
    // dynamic signedInProfile = profiles.where((profile) {
    //   return profile.id == auth.uid;
    // });
    // print(signedInProfile);

    return Container();
  }
}
