import 'package:flutter/material.dart';
import 'package:small_talk/screens/conversations/conversation_tile.dart';
import 'package:small_talk/screens/conversations/search_form.dart';
import 'package:small_talk/services/database.dart';
import 'package:small_talk/shared/constants.dart';

class ConversationsPage extends StatefulWidget {
  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {

  DatabaseService databaseService = DatabaseService();
  Stream conversationsStream;

  @override
  void initState() {
    databaseService.getUserConversations(Constants.myName)
        .then((val) {
      setState(() {
        conversationsStream = val;
      });
    });
    super.initState();
  }

  Widget conversationList() {
    return StreamBuilder(
      stream: conversationsStream,
        builder: (context, snapshot){
          return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return ConversationTile(
                  snapshot.data.documents[index].data["conversationId"]
                      .toString().replaceAll("_", " ")
                      .replaceAll(Constants.myName, " "),
                  snapshot.data.documents[index].data["conversationId"]
                );
              }) : Container();
    });
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
    return Scaffold(
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
      body: conversationList(),
    );
  }
}

