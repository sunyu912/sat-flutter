import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutterappdemo2/take_picture.dart';
import 'package:getflutter/getflutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'GlobalInfo.dart';


class GroupChatPage extends StatefulWidget {

  var targetUser;

  GroupChatPage(this.targetUser);

  @override
  _GroupChatPageState createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {

  var messageController = TextEditingController();
  var scrollController = ScrollController();

  var messageList = [];

  var messagePath = "messages";


  @override
  void initState() {
    if (widget.targetUser != 'group') {
      messagePath =
          widget.targetUser.compareTo(GlobalInfo.userInfo['uid']) > 0 ?
          widget.targetUser + "-" + GlobalInfo.userInfo['uid']
              :
          GlobalInfo.userInfo['uid'] + "-" + widget.targetUser;
    }

    refreshMessages();

    FirebaseDatabase.instance.reference().child(messagePath).onChildAdded.listen((event) {
      print("New messaged is added!");
      refreshMessages();
    });
  }

  void refreshMessages() {
    FirebaseDatabase.instance.reference().child(messagePath).once()
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
      backgroundColor: Color(0xFFEBEBEB),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: messageList.length,
                  itemBuilder: (BuildContext context, int index) {

                    // return  a > b ? true : false;

                    return
                      GlobalInfo.userInfo['uid'] == messageList[index]['uid'] ?
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA0E759),
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
//                                  width: 280,
                                  padding: EdgeInsets.all(10),
                                  child: messageList[index]['message'].startsWith("https") ?
                                  Image.network(messageList[index]['message'])
                                  :
                                  Text(
                                    messageList[index]['message'],
                                    style: TextStyle(
                                        fontSize: 16
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  child: Text(
                                    'Sent at ${DateTime.fromMillisecondsSinceEpoch(messageList[index]['timestamp']).toString()}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: GFAvatar(
                                  backgroundImage: NetworkImage('https://bnbkeepers.com/assets/avatars/profile-pic.jpg'),
                                  shape: GFAvatarShape.standard
                              ),
                            ),
                          ],
                        ),
                      )
                      :
                      Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5),
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
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
//                                width: 280,
                                padding: EdgeInsets.all(10),
                                child: messageList[index]['message'].startsWith('https') ?
                                Image.network(messageList[index]['message'])
                                :
                                Text(
                                    messageList[index]['message'],
                                    style: TextStyle(
                                      fontSize: 16
                                    ),
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 3),
                                child: Text(
                                  'Sent at ${DateTime.fromMillisecondsSinceEpoch(messageList[index]['timestamp']).toString()}',
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
                  icon: Icon(Icons.camera_alt),
                  onPressed: () async {
                    // Obtain a list of the available cameras on the device.
                    final cameras = await availableCameras();
                    // Get a specific camera from the list of available cameras.
                    final firstCamera = cameras.first;
                    // Go to the take picture screen
                    var url = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera)),
                    );

                    print("final url " + url);
                    var timestamp = new DateTime.now().millisecondsSinceEpoch;
                    var message = {
                      'uid' : GlobalInfo.userInfo['uid'],
                      'name' : GlobalInfo.userInfo['name'],
                      'timestamp' : timestamp,
                      'message' : url,
                    };
                    // send the message to Firebase
                    FirebaseDatabase.instance.reference().child(messagePath + "/" + timestamp.toString())
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
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // form a message
                    var timestamp = new DateTime.now().millisecondsSinceEpoch;
                    var message = {
                      'uid' : GlobalInfo.userInfo['uid'],
                      'name' : GlobalInfo.userInfo['name'],
                      'timestamp' : timestamp,
                      'message' : messageController.text,
                    };
                    // send the message to Firebase
                    FirebaseDatabase.instance.reference().child(messagePath + "/" + timestamp.toString())
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
