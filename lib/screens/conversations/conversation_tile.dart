import 'package:flutter/cupertino.dart';
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

        // Can't set these variables without the page twitching for a second. Can't assign them inside the return either.

//        String otherUser = usernames.where((username) => username != userData.username).toString()
//            .replaceAll("(", "")
//            .replaceAll(")", "");
//        String otherUserImage = images.where((image) => image != userData.image).toString()
//            .replaceAll("(", "")
//            .replaceAll(")", "");

        return snapshot.hasData ? GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Conversation(
                    usernames.where((username) => username != userData.username).toString()
                      .replaceAll("(", "")
                      .replaceAll(")", ""),
                    images.where((image) => image != userData.image).toString()
                      .replaceAll("(", "")
                      .replaceAll(")", ""),
                    userData.username,
                    userData.image,
                    conversationId,
                ),
            ));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            margin: EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 0.0),
            padding: EdgeInsets.fromLTRB(5.0, 3.0, 35.0, 3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[800],
                  child: ClipOval(
                    child: SizedBox(
                      width: 60.0,
                      height: 60.0,
                      child: images.where((image) => image != userData.image).toString()
                                .replaceAll("(", "")
                                .replaceAll(")", "")!= null
                          ? Image.network(
                          images.where((image) => image != userData.image).toString()
                                .replaceAll("(", "")
                                .replaceAll(")", ""),
                        fit: BoxFit.fill)
                          : Image.asset(
                        "assets/avatar.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Text(
                  usernames.where((username) => username != userData.username).toString()
                      .replaceAll("(", "")
                      .replaceAll(")", ""),
                  style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 18.0
                  ),
                ),
              ],
            ),
          ),
        ) : Container();
      });
  }
}

