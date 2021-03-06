import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_talk/models/user.dart';
import 'package:small_talk/screens/connections/connections_page.dart';
import 'package:small_talk/screens/conversations/conversations_page.dart';
import 'package:small_talk/screens/home/profile.dart';
import 'package:small_talk/screens/logout.dart';
import 'package:small_talk/screens/topics/topics_page.dart';
import 'package:small_talk/services/auth.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  int _currentIndex = 2;

   userLogout() {
    return CupertinoAlertDialog(
      title: Text(
          "Logout?",
        style: TextStyle(color: Colors.red[900],),
      ),
      actions: [
        FlatButton(
            onPressed: () {
              _auth.signOut();
              setState(() {
                _currentIndex = 2;
              });
            },
            child: Text("Yes"),
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              _currentIndex = 2;
            });
          },
          child: Text("No"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    final tabs = [
      TopicsPage(),
      ConversationsPage(user.uid),
      Profile(),
      ConnectionsPage(user.uid),
      Logout(userLogout()),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[400],
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
                Icons.list,
                color: Colors.red[900],
            ),
            title: Text(
                'Topics',
                style: TextStyle(
                  color: Colors.red[900],
                ),
            ),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              color: Colors.red[900],
            ),
            title: Text(
              'Messages',
              style: TextStyle(
                color: Colors.red[900],
              ),
            ),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.red[900],
              size: 30.0,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Colors.red[900],
              ),
            ),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              color: Colors.red[900],
            ),
            title: Text(
              'Connections',
              style: TextStyle(
                color: Colors.red[900],
              ),
            ),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.red[900],
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: Colors.red[900],
              ),
            ),
            backgroundColor: Colors.white,
          ),
        ],
        onTap:(index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
