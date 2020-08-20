import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/models/user_profile.dart';
import 'package:small_talk/screens/connections/connection_tile.dart';

class ConnectionsList extends StatefulWidget {

  List connections;
  ConnectionsList(this.connections);

  @override
  _ConnectionsListState createState() => _ConnectionsListState();
}

class _ConnectionsListState extends State<ConnectionsList> {
  @override
  Widget build(BuildContext context) {

    final otherUsers = Provider.of<List<UserProfile>>(context);

    return otherUsers != null  ? ListView.builder(
      itemCount: otherUsers.where((otherUser) {
        return widget.connections.contains(otherUser.id);
      }).toList().length,
      itemBuilder: (context, index){
       return ConnectionTile(connection: otherUsers.where((otherUser) {
         return widget.connections.contains(otherUser.id);
       }).toList()[index]);
      }
    ) : Container();
  }
}
