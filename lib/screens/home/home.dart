import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_talk/models/user_profile.dart';
import 'package:small_talk/screens/conversations/conversations_page.dart';
import 'package:small_talk/screens/home/profile.dart';
import 'package:small_talk/services/auth.dart';
import 'package:small_talk/services/database.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/shared/constants.dart';
import 'package:small_talk/shared/helper_functions.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  int _currentIndex = 2;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName =  await HelperFunctions.getUsernameSharedPreferences();
  }

   userLogout() {
    return CupertinoAlertDialog(
      title: Text("Logout?"),
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
    final tabs = [
      null,
      ConversationsPage(),
      Profile(),
      null,
      userLogout(),
    ];

    return StreamProvider<List<UserProfile>>.value(
      value: DatabaseService().profiles,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey,
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
                'Friends',
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
      ),
    );
  }
}
