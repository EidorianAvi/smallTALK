import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/models/user.dart';
import 'package:small_talk/screens/conversations/conversation.dart';
import 'package:small_talk/services/database.dart';

class ConversationTile extends StatelessWidget {
  final List usernames;
  final List images;
  final String conversationId;
  DatabaseService databaseService = DatabaseService();

  ConversationTile({this.usernames, this.images, this.conversationId});


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder(
      stream:  DatabaseService(uid: user.uid).userData,
      builder:(context, snapshot) {

        UserData userData = snapshot.data;

//        dynamic otherUser = usernames.where((username) => username != userData.username);
//        dynamic otherUserImage = images.where((image) => image != userData.image);

        return snapshot.hasData ? GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Conversation(
                    usernames.where((username) => username != userData.username).toString(),
                    images.where((image) => image != userData.image).toString(),
                    conversationId)
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
                    usernames.where((username) => username != userData.username).toString()
                      .replaceAll("(", "")
                      .replaceAll(")", ""),
                  style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 20.0
                  ),
                ),
              ],
            ),
          ),
        ) : Container();
      });
  }
}

