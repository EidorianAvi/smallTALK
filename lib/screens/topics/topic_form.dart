import 'package:flutter/material.dart';
import 'package:small_talk/services/database.dart';
import 'package:small_talk/shared/constants.dart';

class TopicForm extends StatefulWidget {

  @override
  _TopicFormState createState() => _TopicFormState();
}

class _TopicFormState extends State<TopicForm> {
  final _formKey = GlobalKey<FormState>();
  DatabaseService databaseService = new DatabaseService();
  String _currentInput;


  commitTopic(){
    databaseService.createTopic(_currentInput);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {

          return Container(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Create Topic",
                  style: TextStyle(
                    color: Colors.red[900],
                    fontSize: 22.0,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: ""),
                          onChanged: (val) =>
                              setState(() => _currentInput = val),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add_box,
                          color: Colors.red[900],
                        ),
                        onPressed: () {
                          commitTopic();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
