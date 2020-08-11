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
      body: Builder(
        builder: (context) => Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 60.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 100,
                      // backgroundColor: Colors.white,
                      child: ClipOval(
                        child: SizedBox(
                          width: 180.0,
                          height: 180.0,
                          child: Image.asset(
                            'assets/avatar.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child: IconButton(
                      icon: Icon(Icons.camera),
                      onPressed: null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
    );
  }
}
