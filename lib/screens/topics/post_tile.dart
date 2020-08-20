import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/models/user.dart';
import 'package:small_talk/services/database.dart';
import 'package:small_talk/shared/constants.dart';


class PostTile extends StatelessWidget {

  final String topic;
  final String post;
  final String posterName;
  final String posterImage;
  final String posterId;

  PostTile({this.topic, this.post, this.posterName, this.posterImage, this.posterId});
  DatabaseService databaseService = DatabaseService();



  postConfirm(userData, context) {
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: [confirmConversation(userData, context)],
            ),
          );
        });
  }


  Widget confirmConversation(userData, context) {

    Map postUser = {
      "username": posterName,
      "id": posterId,
      "image": posterImage,
    };

    Map<String, dynamic>  messageMap  =  {
      "message": post,
      "sentBy": posterName,
      "time": DateTime.now().millisecondsSinceEpoch,
    };

    String conversationId = getConversationId(posterId, userData.uid);

    return Container(
      width: 250,
      height: 225,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
              "Posted By",
              style: TextStyle(
                color: Colors.red[900],
                fontSize: 18.0,
              ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[800],
                child: ClipOval(
                  child: SizedBox(
                    width: 60.0,
                    height: 60.0,
                    child: posterImage != null
                        ? Image.network(posterImage, fit: BoxFit.fill)
                        : Image.asset(
                      "assets/avatar.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 40.0),
              Expanded(
                child: Text(
                    posterName,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Text(
              post,
            style: TextStyle(fontSize: 14.0),
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.grey[200],
            child: Text(
                "Chat",
                style: TextStyle(
                    color: Colors.red[700],
                  fontSize: 20.0,
                ),
            ),
            onPressed: () async {
              startConversation(postUser, userData, context);
              databaseService.updatePostStatus(topic, post);
              databaseService.addConversationMessages(conversationId, messageMap);
            },
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);



    return StreamBuilder(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot){

          UserData userData = snapshot.data;

          return snapshot.hasData ? GestureDetector(
            onTap: () {
              postConfirm(userData, context);
            },
            child: Container(
              color: Colors.grey[100],
              margin: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0.0),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Text(
                post,
                style: TextStyle(
                    color: Colors.red[900],
                    fontSize: 20.0
                ),
              ),
            ),
          ) : Container();
        }
    );
  }
}

