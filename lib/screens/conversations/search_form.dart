import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/models/user.dart';
import 'package:small_talk/screens/conversations/conversation.dart';
import 'package:small_talk/services/database.dart';
import 'package:small_talk/shared/constants.dart';

class SearchForm extends StatefulWidget {


  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  DatabaseService databaseService = new DatabaseService();
  String _currentUsername;
  QuerySnapshot searchSnapshot;

  searchForUser() {
    databaseService.getUserByUsername(_currentUsername).then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget searchList(loggedInUser) {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (context, index) {
              return SearchTile(
                username: searchSnapshot.documents[0].data["username"],
                image: searchSnapshot.documents[0].data["image"],
                loggedInUser: loggedInUser,
              );
            })
        : Container();
  }

  Widget SearchTile({String username, String image, UserData loggedInUser}) {
    var searchedUser = searchSnapshot.documents[0].data;

    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[800],
            child: ClipOval(
              child: SizedBox(
                width: 75.0,
                height: 75.0,
                child: image != null
                    ? Image.network(image, fit: BoxFit.fill)
                    : Image.asset(
                        "assets/avatar.jpg",
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
          SizedBox(width: 45.0),
          Column(
            children: [
              Text(
                username,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.message,
                  color: Colors.red[900],
                ),
                onPressed: () {
                  Navigator.pop(context);
                  startConversation(searchedUser, loggedInUser);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  getConversationId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  startConversation(searchedUser, loggedInUser) {
    List<String> users = [searchedUser['username'], loggedInUser.username];
    List<String> userIds = [searchedUser['id'], loggedInUser.uid];
    List<String> userImages = [searchedUser['image'], loggedInUser.image];
    String conversationId =
        getConversationId(searchedUser['id'], loggedInUser.uid);
    Map<String, dynamic> conversationMap = {
      "users": users,
      "userIds": userIds,
      "userImages": userImages,
      "conversationId": conversationId,
      "time": DateTime.now().millisecondsSinceEpoch,
    };
    databaseService.createConversation(conversationId, conversationMap);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Conversation(searchedUser['username'],
                searchedUser['image'], loggedInUser.username, loggedInUser.image, conversationId)));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
            return snapshot.hasData ? Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    "Search by Username",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.red[900],
                    ),
                  ),
                  SizedBox(height: 25.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: "Username"),
                          onChanged: (val) =>
                              setState(() => _currentUsername = val),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.red[900],
                        ),
                        onPressed: () {
                          searchForUser();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 40.0),
                  searchList(snapshot.data),
                ],
              ),
            ) : Container() ;
        });
  }
}
