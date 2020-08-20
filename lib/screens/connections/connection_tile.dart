import 'package:flutter/material.dart';
import 'package:small_talk/models/user_profile.dart';

class ConnectionTile extends StatelessWidget {

  final UserProfile connection;

  ConnectionTile({this.connection});

  @override
  Widget build(BuildContext context) {
    print(connection.image);
    return Padding(
      padding: const EdgeInsets.fromLTRB(9.0, 10.0, 9.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2.0, color: Colors.grey[300]),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 100.0,
              width: 100.0,
              decoration: BoxDecoration(
                image:  DecorationImage(
                  image: NetworkImage(connection.image),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              height:110,
              width: 170,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      connection.username,
                      style: TextStyle(
                        color: Colors.red[900],
                        fontSize: 20.0,
                      ),
                  ),
                  Text(
                    connection.bio,
                    style: TextStyle(fontSize: 15.0)
                  ),
                ],
              )
            ),
            SizedBox(width: 15),
            IconButton(
              icon: Icon(
                  Icons.message,
                color: Colors.red[900]
              ),
            ),
            SizedBox(width: 12),
            Column(
              children: [
                Text('x', style: TextStyle(fontSize: 18.0, color: Colors.grey[600])),
                SizedBox(height: 80)
              ],
            )
          ],
        ),
      ),
    );
  }
}
