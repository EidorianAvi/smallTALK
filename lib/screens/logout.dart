import 'dart:async';

import 'package:flutter/material.dart';

class Logout extends StatefulWidget {
  Widget userLogout;
  Logout(this.userLogout);

  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  Widget userLogout;

  @override
  void initState() {
    logUserOut();
    super.initState();
  }

  logUserOut() {
    Timer(const Duration(milliseconds: 1), () {
      setState(() {
        userLogout= widget.userLogout;
      });
    });
  }

  @override

  Widget build(BuildContext context) {
    logUserOut();
    return Container(
      child: userLogout,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/logout.jpg'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
