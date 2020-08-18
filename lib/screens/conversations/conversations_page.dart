import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/models/user.dart';
import 'package:small_talk/screens/conversations/conversation_tile.dart';
import 'package:small_talk/screens/conversations/search_form.dart';
import 'package:small_talk/services/database.dart';

class ConversationsPage extends StatefulWidget {

  String uid;

  ConversationsPage(this.uid);

  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {

  DatabaseService databaseService = DatabaseService();
  Stream conversationsStream;
  UserData user;

  @override
  void initState() {
    getUserConversations()
      .then((val) {
       setState(() {
         conversationsStream = val;
       });
    });
    super.initState();
  }

  getUserConversations() async {
    return await databaseService.getUserConversations(widget.uid);
  }


  Widget conversationList(loggedInUser){
      return loggedInUser != null ? StreamBuilder(
          stream: conversationsStream,
          builder: (context, snapshot){
            return snapshot.hasData ? SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return ConversationTile(
                        usernames: snapshot.data.documents[index].data['users'],
                        images: snapshot.data.documents[index].data['userImages'],
                        conversationId: snapshot.data.documents[index].data['conversationId'],
                    );
                  }),
            ) : Container();
          }
      ) : Container();
  }


  void _showSearchPanel() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        backgroundColor: Colors.grey[50],
        context: context,
        builder: (context) {
          return Padding(
            padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SearchForm(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return user != null ? StreamBuilder(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        return snapshot.hasData ?
        Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Conversations", style: TextStyle(color: Colors.red[900])),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.red[900],
                ),
                onPressed: (){
                  _showSearchPanel();
                },
              ),
            ],
          ),
          body: conversationList(snapshot.data),
        ) : Container();
      },
    ) : Container();
  }
}

