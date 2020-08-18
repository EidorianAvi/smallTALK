import 'package:flutter/material.dart';
import 'package:small_talk/screens/conversations/message_tile.dart';
import 'package:small_talk/services/database.dart';
import 'package:small_talk/shared/constants.dart';


class Conversation extends StatefulWidget {

  final String conversationId;
  String username;
  String image;

  Conversation(this.username, this.image, this.conversationId);


  @override
  _ConversationState createState() => _ConversationState(username);
}

class _ConversationState extends State<Conversation> {

  String username;
  _ConversationState(this.username);

  Stream messageStream;
  DatabaseService databaseService = DatabaseService();
  TextEditingController messageController = new TextEditingController();


  @override
  void initState() {
    databaseService.getConversationMessages(widget.conversationId)
      .then((value){
        setState(() {
          messageStream = value;
//          print(messageStream);
        });
    });
    super.initState();
  }

  Widget messageList(){
    if(messageStream != null) {
      print(messageStream);
      return StreamBuilder(
        stream: messageStream,
          builder: (context, snapshot){
          return snapshot.hasData ? SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                return MessageTile(snapshot.data.documents[index].data["message"],
                snapshot.data.documents[index].data['sentBy'] == Constants.myName);
                }),
          ) : Container(
            child: Text("Loading"),
          );
          }
      );
    } else {
      return Container();
    }
  }

  sendMessage() {

    if(messageController.text.isNotEmpty){
      Map<String, dynamic>  messageMap  =  {
        "message": messageController.text,
        "sentBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      setState(() {
        messageController.text = '';
      });
       databaseService.addConversationMessages(widget.conversationId, messageMap);
       messageController.text = '';
    }
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
          username,
          style: TextStyle(
            color: Colors.red[900],
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            messageList(),
            Container(
              margin: EdgeInsets.only(top: 2.0),
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                        child:TextField(
                          controller: messageController,
                          decoration: textInputDecoration.copyWith(hintText: "Message"),
                        ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.red[900],
                      ),
                      onPressed: () {
                        sendMessage();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
