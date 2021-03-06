import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdemo2/group_chat.dart';
import 'package:flutterappdemo2/map_view.dart';
import 'package:geolocator/geolocator.dart';

import 'GlobalInfo.dart';

class FriendListPage extends StatefulWidget {
  @override
  _FriendListPageState createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {

  var friendList = [];

  _FriendListPageState() {

    Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      print(value);
    });

    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    geolocator.getPositionStream(locationOptions).listen(
            (Position position) {
          print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
        });

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

      friendList.forEach((friend) {
        friend['newMessage'] = false;
        var messagePath =
          friend['uid'].compareTo(GlobalInfo.userInfo['uid']) > 0 ?
          friend['uid'] + "-" + GlobalInfo.userInfo['uid']
              :
          GlobalInfo.userInfo['uid'] + "-" + friend['uid'];

        FirebaseDatabase.instance.reference().child(messagePath).onChildAdded.listen((event) {
          print("New messaged is added! ");
          print(messagePath);
          friend['newMessage'] = true;
        });
      });

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
          RaisedButton(
            child: Text("Map View"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapViewPage()),
              );
            },
          ),
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
                            Text(
                                "${friendList[index]['name']} | ",
                              style: TextStyle(
                                color: friendList[index]['newMessage'] ? Colors.red : Colors.black
                              ),
                            ),
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
