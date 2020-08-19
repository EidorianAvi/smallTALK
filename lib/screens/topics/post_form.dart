import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/models/user.dart';
import 'package:small_talk/services/database.dart';
import 'package:small_talk/shared/constants.dart';

class PostForm extends StatefulWidget {

  String topic;
  PostForm(this.topic);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();
  DatabaseService databaseService = new DatabaseService();
  String _currentPost;


  commitPost(userData){
    
    Map<String, dynamic> postMap = {
      "post": _currentPost,
      "postedBy": userData.username,
      "posterImage": userData.image,
      "posterId": userData.uid,
      "time": DateTime.now().millisecondsSinceEpoch,
      "isTaken": false,
    };

    databaseService.createPost(widget.topic, postMap);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {

          UserData userData = snapshot.data;

          return snapshot.hasData ?

          Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                    "Drop a Chat",
                  style: TextStyle(
                    color: Colors.red[900],
                    fontSize: 22.0,
                  ),
                ),
                Form(
                  key: _formKey,
                    child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: ""),
                              onChanged: (val) =>
                                  setState(() => _currentPost = val),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add_box,
                              color: Colors.red[900],
                            ),
                            onPressed: () {
                              commitPost(userData);
                            },
                          ),
                        ],
                      ),
                 ),
              ],
            ),
          ) : Container() ;
        });
  }
}
