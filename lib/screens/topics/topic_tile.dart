import 'package:flutter/material.dart';
import 'package:small_talk/screens/topics/topic_board.dart';
import 'package:small_talk/shared/constants.dart';



class TopicTile extends StatelessWidget {

  final String topic;
  TopicTile(this.topic);


  addToFavorites() {

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => TopicBoard(topic)
        ));
      },
      child: Container(
        color: Colors.grey[100],
        margin: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0.0),
//        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              topic,
              style: TextStyle(
                  color: Colors.red[900],
                  fontSize: 20.0
              ),
            ),
            IconButton(
              iconSize: 20.0,
              icon: Icon(
                Icons.star_border,
                color: Colors.grey,
              ),
              onPressed: (){
                addToFavorites();
              },
            ),
          ],
        ),
      ),
    );
  }
}

