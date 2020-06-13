import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

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
                      margin: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text(messageList[index]['message']),
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
                        }).catchError((error) {
                          print("Failed to send the message");
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
