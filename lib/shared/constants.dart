import 'package:flutter/material.dart';

final textInputDecoration = InputDecoration(
  hintText: "Email",
  fillColor: Colors.grey[50],
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey[800], width: 2.5),
  ),
);
