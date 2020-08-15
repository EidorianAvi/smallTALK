import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:small_talk/models/user.dart';
import 'package:small_talk/screens/home/update_form.dart';
import 'package:small_talk/services/database.dart';
import 'package:small_talk/shared/loading_spin.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    void _showUpdatePanel() {
      showModalBottomSheet(
        isScrollControlled: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          backgroundColor: Colors.grey[300],
          context: context,
          builder: (context) {
            return Padding(
              padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: UpdateForm(),
              ),
            );
          });
    }

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoadingSpin();

        return Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 92,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                    child: SizedBox(
                      width: 180.0,
                      height: 180.0,
                      child: (snapshot.data.image == 'assets/avatar.png')
                      ? Image.asset(
                        "assets/avatar.jpg",
                        fit: BoxFit.fill
                      )
                      : Image.network(
                          snapshot.data.image,
                          fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                snapshot.data.username,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.lightBlue[200],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                snapshot.data.bio,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              FlatButton.icon(
                label: Text(
                  "Edit Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20.0,
                ),
                onPressed: () => _showUpdatePanel(),
              ),
            ],
          ),
        );
      },
    );
  }
}
