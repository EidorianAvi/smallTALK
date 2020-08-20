import 'package:flutter/material.dart';
import 'package:small_talk/screens/conversations/conversation.dart';
import 'package:small_talk/services/database.dart';

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



getConversationId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}

startConversation(otherUser, loggedInUser, context) {
  List<String> users = [otherUser['username'], loggedInUser.username];
  List<String> userIds = [otherUser['id'], loggedInUser.uid];
  List<String> userImages = [otherUser['image'], loggedInUser.image];
  String conversationId =
  getConversationId(otherUser['id'], loggedInUser.uid);
  Map<String, dynamic> conversationMap = {
    "users": users,
    "userIds": userIds,
    "userImages": userImages,
    "conversationId": conversationId,
    "time": DateTime.now().millisecondsSinceEpoch,
  };
  DatabaseService().createConversation(conversationId, conversationMap);
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Conversation(otherUser['username'],
              otherUser['image'], loggedInUser.username, loggedInUser.image, conversationId)));
}


