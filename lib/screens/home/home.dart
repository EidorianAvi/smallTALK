import 'package:flutter/material.dart';
import 'package:small_talk/models/user_profile.dart';
import 'package:small_talk/screens/home/favorites.dart';
import 'package:small_talk/screens/home/profile.dart';
import 'package:small_talk/services/auth.dart';
import 'package:small_talk/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserProfile>>.value(
      value: DatabaseService().profile,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[700],
        body: Column(
          children: [
            Profile(),
            SizedBox(height: 25.0),
            Favorites(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                color: Colors.red[900],
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              IconButton(
                color: Colors.red[900],
                icon: Icon(Icons.message),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 40.0,
                color: Colors.red[900],
                icon: Icon(Icons.home),
                onPressed: () {},
              ),
              IconButton(
                color: Colors.red[900],
                icon: Icon(Icons.people),
                onPressed: () {},
              ),
              IconButton(
                color: Colors.red[900],
                splashColor: Colors.black,
                icon: Icon(Icons.exit_to_app),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
