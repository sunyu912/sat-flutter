import 'dart:async';
import 'package:getflutter/getflutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class GroupChatPage extends StatefulWidget {
  @override
  _GroupChatPageState createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {

  var messageController = TextEditingController();
  var scrollController = ScrollController();

  var messageList = [];

  _GroupChatPageState() {
    refreshMessages();

    FirebaseDatabase.instance.reference().child("messages").onChildAdded.listen((event) {
      print("New messaged is added!");
      refreshMessages();
    });
  }

  void refreshMessages() {
    FirebaseDatabase.instance.reference().child("messages").once()
        .then((ds) {
      print(ds.key);
      print(ds.value);
      var tempMsgList = [];
      ds.value.forEach((k, v) {
        tempMsgList.add(v);
      });

      tempMsgList.sort((a, b) {
        return a['timestamp'].compareTo(b['timestamp']);
      });

      messageList = tempMsgList;
      setState(() {
        Timer(
          Duration(seconds: 1),
              () => scrollController.jumpTo(scrollController.position.maxScrollExtent),
        );
      });
    }).catchError((error) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: messageList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            child: GFAvatar(
                                backgroundImage: NetworkImage('https://bnbkeepers.com/assets/avatars/profile-pic.jpg'),
                                shape: GFAvatarShape.standard
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFA0E759),
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                                width: 280,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                    messageList[index]['message'],
                                    style: TextStyle(
                                      fontSize: 16
                                    ),
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Text(
                                  'Sent at ${new DateTime.fromMillisecondsSinceEpoch(messageList[index]['timestamp']).toString()}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Type your message here',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // form a message
                    var timestamp = new DateTime.now().millisecondsSinceEpoch;
                    var message = {
                      'timestamp' : timestamp,
                      'message' : messageController.text,
                    };
                    // send the message to Firebase
                    FirebaseDatabase.instance.reference().child("messages/" + timestamp.toString())
                        .set(message)
                        .then((value) {
                          print("Message sent");
                          messageController.text = "";
                          FocusScope.of(context).requestFocus(FocusNode());
                    }).catchError((error) {
                          print("Failed to send the message");
                          messageController.text = "";
                          FocusScope.of(context).requestFocus(FocusNode());
                    });

                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
