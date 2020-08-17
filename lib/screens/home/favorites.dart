import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
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
          SizedBox(height: 110.0),
          favorites == null
              ? Container(
                child: Text(
                    "No Favorites Selected",
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.grey[700].withOpacity(0.6),
                    ),
                ),
              )
              : null
        ],
      ),

    );
  }
}
