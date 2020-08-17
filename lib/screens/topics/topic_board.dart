import 'package:flutter/material.dart';

class TopicBoard extends StatefulWidget {

  final String topic;
  TopicBoard(this.topic);

  @override
  _TopicBoardState createState() => _TopicBoardState();
}

class _TopicBoardState extends State<TopicBoard> {
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
        color: Colors.grey[300]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.red[900]),
        backgroundColor: Colors.white,
      ),

    );
  }
}
