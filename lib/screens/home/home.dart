import 'package:flutter/material.dart';
import 'package:small_talk/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
              icon: Icon(Icons.logout),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
      ),
      // appBar: AppBar(
      //   title: Text(
      //     'Small Talk',
      //     style: TextStyle(
      //       color: Colors.red[900],
      //     ),
      //   ),
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      //   actions: <Widget>[
      //     FlatButton.icon(
      //       icon: Icon(Icons.person),
      //       label: Text(
      //         'Logout',
      //         style: TextStyle(
      //           color: Colors.red[900],
      //         ),
      //       ),
      //       onPressed: () async {
      //         await _auth.signOut();
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
