import 'package:flutter/material.dart';
import 'package:small_talk/models/user.dart';
import 'package:small_talk/screens/topics/topic_tile.dart';

class Favorites extends StatefulWidget {

  UserData userData;

  Favorites(this.userData);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List favorites;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
                "    Favorite Topics    ",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 26.0,
                letterSpacing: 1.0,
                color: Colors.white,
              ),
          ),
          widget.userData.favorites.isEmpty
          ? SizedBox(height: 110.0) : Container(),
          widget.userData.favorites.isEmpty
              ? Container(
                child: Text(
                    "No Favorites Selected",
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.grey[700].withOpacity(0.6),
                    ),
                ),
              )
              : Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                      itemCount: widget.userData.favorites.length,
                      itemBuilder: (context, index){
                        return TopicTile(widget.userData.favorites[index]);
                      }),
                ),
        ],
      ),

    );
  }
}
