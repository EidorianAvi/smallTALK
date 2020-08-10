import 'package:flutter/material.dart';

final textInputDecoration = InputDecoration(
  hintText: "Email",
  fillColor: Colors.grey[400],
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.0),
  ),
);
