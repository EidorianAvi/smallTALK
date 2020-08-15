import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSpin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.grey[50],
        child: Center(
          child: SpinKitChasingDots(
            color: Colors.red[900],
            size: 75.0,
          ),
        ),
      ),
    );
  }
}
