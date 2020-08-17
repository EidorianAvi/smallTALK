import 'package:flutter/material.dart';

final textInputDecoration = InputDecoration(
  hintText: "Email",
  hintStyle: TextStyle(
    color: Colors.grey[800],
    fontSize: 22.0,
  ),
  fillColor: Colors.grey[50].withOpacity(.4),
  filled: true,
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.5),
  ),
);


class Constants {
  static String myName;
  static String myImage;
  static List myFavorites;
}