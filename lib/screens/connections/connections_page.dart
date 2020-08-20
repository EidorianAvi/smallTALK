import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/models/user_profile.dart';
import 'package:small_talk/screens/connections/connections_list.dart';
import 'package:small_talk/screens/conversations/search_form.dart';
import 'package:small_talk/services/database.dart';

class ConnectionsPage extends StatefulWidget {

  String uid;
  ConnectionsPage(this.uid);

  @override
  _ConnectionsPageState createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage> {
  DatabaseService databaseService = DatabaseService();
  QuerySnapshot loggedInUser;

  @override
  void initState() {
    getUser()
        .then((val) {
            setState(() {
              loggedInUser = val;
            });
        });
    super.initState();
  }

  getUser() {
    return databaseService.getUserByUid(widget.uid);
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


        return loggedInUser != null ? StreamProvider<List<UserProfile>>.value(
          value: DatabaseService().profiles,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.search, color: Colors.red[900]),
                  onPressed: (){
                    _showSearchPanel();
                  },
                )
              ],
              backgroundColor: Colors.white,
              title: Text(
                "Connections",
                style: TextStyle(
                    color: Colors.red[900]
                ),
              ),
            ),
            body: ConnectionsList(loggedInUser.documents[0].data['connections']),
          ),
        ) : Container();
      }
}
