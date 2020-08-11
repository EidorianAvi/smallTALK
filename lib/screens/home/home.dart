import 'package:flutter/material.dart';
import 'package:small_talk/models/user_profile.dart';
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
    // dynamic authUser = _auth.user;
    // _auth.userFromFirebaseUser(authUser);
    // print(authUser);

    return StreamProvider<List<UserProfile>>.value(
      value: DatabaseService().profile,
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Profile(auth: _auth),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                // child: Text('Topics'),
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
                icon: Icon(Icons.logout),
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
