import 'package:flutter/material.dart';

class FriendListPage extends StatefulWidget {
  @override
  _FriendListPageState createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {

  var friendList = [];



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
                    return Container(
                      child: Row(
                        children: [
                          Text("$friendList[index]['name']"),
                          Text("$friendList[index]['school']")
                        ],
                      ),
                    );
                  })
          )
        ],
      ),
    );
  }
}
