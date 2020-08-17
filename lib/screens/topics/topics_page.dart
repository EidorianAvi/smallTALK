import 'package:flutter/material.dart';
import 'package:small_talk/screens/topics/topic_tile.dart';
import 'package:small_talk/services/database.dart';

class TopicsPage extends StatefulWidget {
  @override
  _TopicsPageState createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {

  DatabaseService databaseService = DatabaseService();
  Stream topicsStream;


  Widget topicList() {
    return StreamBuilder(
        stream: topicsStream,
        builder: (context, snapshot){
          return snapshot.hasData ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return TopicTile(snapshot.data.documents[index].data['topic']);
              }) : Container();
        });
  }

  @override
  void initState() {
    databaseService.getTopics()
        .then((val) {
      setState(() {
        topicsStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
            "Topics",
          style: TextStyle(
            color: Colors.red[900]
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
                Icons.add,
              color: Colors.red[900],
            ),
            onPressed: (){print("add topic");},
          ),
        ],
      ),
      body: topicList(),
    );
  }
}

