import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdemo2/group_chat.dart';

import 'GlobalInfo.dart';

class FriendListPage extends StatefulWidget {
  @override
  _FriendListPageState createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {

  var friendList = [];
  _FriendListPageState() {
    FirebaseDatabase.instance.reference().child("users").once().then((value) {
      print("Successfully loaded the student data.");
      var stuList = [];
      value.value.forEach((k, v) {
        print(k);
        print(v);
        stuList.add(v);
      });
      print(stuList);
      friendList = stuList;
      setState(() {

      });
    }).catchError((error) {
      print("Failed to load the student data." + error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Test"),
          Expanded(
              child: ListView.builder(
                  itemCount: friendList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        print(friendList[index]['uid']);
                        print(GlobalInfo.userInfo['uid']);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GroupChatPage(friendList[index]['uid'])),
                        );
                      },
                      title: Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Text("${friendList[index]['name']} | "),
                            Text("${friendList[index]['school']}")
                          ],
                        ),
                      ),
                    );
                  })
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GroupChatPage('group')),
          );
        },
      ),
    );
  }
}
