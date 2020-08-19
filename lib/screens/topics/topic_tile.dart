
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/models/user.dart';
import 'package:small_talk/screens/topics/topic_board.dart';
import 'package:small_talk/services/database.dart';

class TopicTile extends StatelessWidget {

  final String topic;
  TopicTile(this.topic);
  DatabaseService databaseService = DatabaseService();


  addToFavorites(userData, context) async {
      DocumentReference docRef = Firestore.instance.collection('profile').document(userData.uid);
      DocumentSnapshot doc = await docRef.get();
      List favorites = doc.data['favorites'];
      if(favorites.contains(topic)){
        docRef.updateData(
          {
          'favorites': FieldValue.arrayRemove([topic])
          }
        );
      } else if (favorites.length < 3){
        docRef.updateData(
          {
            "favorites": FieldValue.arrayUnion([topic])
          }
        );
      } else if(favorites.length == 3 && !favorites.contains(topic)){
        Scaffold.of(context).showSnackBar(
          SnackBar(
              content: Text("You can only have 3 favorites selected")
          ),
        );
      }
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){

        UserData userData = snapshot.data;

        return snapshot.hasData ? GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => TopicBoard(topic)
            ));
          },
          child: Container(
            color: Colors.grey[100],
            margin: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0.0),
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
                  iconSize: 22.0,
                  icon: !userData.favorites.contains(topic) ?
                  Icon(
                    Icons.star_border,
                    color: Colors.grey,
                  )
                  : Icon(
                    Icons.star,
                    color: Colors.amberAccent
                  ),
                  onPressed: (){
                    print(userData.favorites);
                    addToFavorites(userData, context);
                  },
                ),
              ],
            ),
          ),
        ) : Container();
      }
    );
  }
}

