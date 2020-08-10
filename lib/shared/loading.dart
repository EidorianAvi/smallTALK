import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: Center(
        child: SpinKitFadingCube(
          color: Colors.red[900],
          size: 75.0,
        ),
      ),
    );
  }
}
