import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_talk/screens/topics/post_form.dart';
import 'package:small_talk/screens/topics/post_tile.dart';
import 'package:small_talk/services/database.dart';

class TopicBoard extends StatefulWidget {

  final String topic;
  TopicBoard(this.topic);

  @override
  _TopicBoardState createState() => _TopicBoardState();
}

class _TopicBoardState extends State<TopicBoard> {

  TextEditingController messageController = new TextEditingController();
  DatabaseService databaseService = DatabaseService();
  Stream postStream;

  @override
  void initState() {
    databaseService.getPosts(widget.topic)
        .then((val) {
            setState(() {
              postStream = val;
            });
    });
    super.initState();
  }

  Widget postList() {
    return postStream != null ? StreamBuilder(
        stream: postStream,
        builder: (context, snapshot){
          return snapshot.hasData && snapshot.data.documents.length > 0 ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return PostTile(
                    topic: widget.topic,
                    post: snapshot.data.documents[index].data['post'],
                    posterName: snapshot.data.documents[index].data['postedBy'],
                    posterImage: snapshot.data.documents[index].data['posterImage'],
                    posterId: snapshot.data.documents[index].data['posterId'],
                );
              }) : Center(
            child: Container(
                child: Text(
                    "Currently No Posts",
                  style: TextStyle(
                    color: Colors.grey[700].withOpacity(.7),
                    fontSize: 30.0,
                  ),
                ),
            ),
          );
        }) : Container();
  }

  postTopicForm(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: Stack(
            overflow: Overflow.visible,
            children: [PostForm(widget.topic)],
        ),
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.red[900],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          widget.topic,
          style: TextStyle(
            color: Colors.red[900],
          ),
        ),
      ),
      body: postStream != null ? postList() : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postTopicForm(context);
        },
        child: Icon(Icons.add, color: Colors.red[900]),
        backgroundColor: Colors.white,
      ),
    );
  }
}
