import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final bool sentByMe;

  MessageTile(this.message, this.sentByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
        decoration: BoxDecoration(
            borderRadius: sentByMe
                ? BorderRadius.all(Radius.circular(20.0))
                : BorderRadius.all(Radius.circular(20.0)),
            color: sentByMe
                ? Colors.red[900]
                : Colors.black
        ),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.grey[50],
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
