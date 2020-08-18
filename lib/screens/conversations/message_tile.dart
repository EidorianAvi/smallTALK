import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String otherUserImage;
  final String loggedInUserImage;
  final String message;
  final bool sentByMe;

  MessageTile({this.otherUserImage, this.loggedInUserImage, this.message, this.sentByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      margin: sentByMe ? EdgeInsets.only(left: 30.0) : EdgeInsets.only(right: 30.0),
      child: Row(
        mainAxisAlignment: sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          SizedBox(width: 5.0),
          !sentByMe ?
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey[800],
            child: ClipOval(
              child: SizedBox(
                width: 32.0,
                height: 32.0,
                child: Image.network(
                    otherUserImage,
                    fit: BoxFit.fill
                ),
              ),
            ),
          ) : Container(),
          !sentByMe ? SizedBox(width: 5.0) : Container(),
          Flexible(
            child: Container(
//              alignment: sentByMe ? Alignment.centerLeft : Alignment.centerRight,
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
          ),
          sentByMe ?
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey[800],
            child: ClipOval(
              child: SizedBox(
                width: 32.0,
                height: 32.0,
                child: Image.network(
                    loggedInUserImage,
                    fit: BoxFit.fill
                ),
              ),
            ),
          ) : Container(),
          SizedBox(width: 5.0),
        ],
      ),
    );
  }
}
