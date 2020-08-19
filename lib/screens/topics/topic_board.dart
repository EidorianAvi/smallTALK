import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_talk/screens/topics/post_form.dart';

class TopicBoard extends StatefulWidget {

  final String topic;
  TopicBoard(this.topic);

  @override
  _TopicBoardState createState() => _TopicBoardState();
}

class _TopicBoardState extends State<TopicBoard> {

  TextEditingController messageController = new TextEditingController();


  postTopicForm(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: Stack(
            overflow: Overflow.visible,
            children: [PostForm()],
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
      body: Container(
        color: Colors.grey[400]
      ),
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
