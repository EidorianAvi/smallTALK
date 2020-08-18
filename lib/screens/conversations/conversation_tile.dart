import 'package:flutter/material.dart';
import 'package:small_talk/screens/conversations/conversation.dart';

class ConversationTile extends StatelessWidget {
  final String username;
  final String conversationId;
  final String image;
  ConversationTile(this.username, this.image, this.conversationId);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Conversation(username, image, conversationId)
        ));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0.0),
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10.0),
            Text(
              username,
              style: TextStyle(
                  color: Colors.red[900],
                  fontSize: 20.0
              ),
            ),
          ],
        ),
      ),
    );
  }
}

