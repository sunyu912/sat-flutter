import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FriendListView extends StatefulWidget {
  @override
  _FriendListViewState createState() => _FriendListViewState();
}

class _FriendListViewState extends State<FriendListView> {

  _FriendListViewState() {
    // let's load all the students data from Firebase
    FirebaseDatabase.instance.reference().child("students").once().then((value) {
      print("Successfully loaded the student data.");
      var stuList = [];
      value.value.forEach((k, v) {
        print(k);
        print(v);
        v['comment'] = 0;
        v['image'] = 'https://www.click2houston.com/resizer/YL2Xl3rUeyUhqkv2G73OhtoRbrY=/1280x914/smart/filters:format(jpeg):strip_exif(true):strip_icc(true):no_upscale(true):quality(65)/cloudfront-us-east-1.images.arcpublishing.com/gmg/WMCWF6HAMBECPFPFNWYQENJYGE.jpg';
        v['min'] = 0;
        v['like'] = 0;
        v['share'] = 0;
        stuList.add(v);
      });
      print(stuList);
    }).catchError((error){
      print("Failed to load the student data.");
    });
  }

  var friendList = [
    {
      "name" : "Aaron",
      "min" : 12,
      "image" : "https://www.click2houston.com/resizer/YL2Xl3rUeyUhqkv2G73OhtoRbrY=/1280x914/smart/filters:format(jpeg):strip_exif(true):strip_icc(true):no_upscale(true):quality(65)/cloudfront-us-east-1.images.arcpublishing.com/gmg/WMCWF6HAMBECPFPFNWYQENJYGE.jpg",
      "like" : 999,
      "comment" : 50,
      "share" : 80
    },
    {
      "name" : "Zach",
      "min" : 50,
      "image" : "https://www.click2houston.com/resizer/YL2Xl3rUeyUhqkv2G73OhtoRbrY=/1280x914/smart/filters:format(jpeg):strip_exif(true):strip_icc(true):no_upscale(true):quality(65)/cloudfront-us-east-1.images.arcpublishing.com/gmg/WMCWF6HAMBECPFPFNWYQENJYGE.jpg",
      "like" : 1000,
      "comment" : 50,
      "share" : 80
    },
    {
      "name" : "Allen",
      "min" : 24,
      "image" : "https://p19cdn4static.sharpschool.com/UserFiles/Servers/Server_125264/Image/News%20Photos/2020/DCHS%20ATHLETIC%20BUILDING%20AND%20STADIUM%20BIRDS%20EYE%20VIEW.jpg",
      "like" : 888,
      "comment" : 50,
      "share" : 80
    },
    {
      "name" : "Eric",
      "min" : 37,
      "image" : "https://suffolktimes.timesreview.com/files/southold_schools_district-1024x768.jpg",
      "like" : 777,
      "comment" : 50,
      "share" : 80
    },
  ];

  void test() {
    true ? friendList[0]['num'] = int.parse(friendList[0]['num'].toString()) + 1 : friendList[0]['num'] = 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: friendList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 5, bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: CircleAvatar(
                              backgroundImage: NetworkImage("https://img.icons8.com/plasticine/2x/user.png"),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${friendList[index]['name']}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("${friendList[index]['min']} Mins"),
                          ],
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: Icon(
                            Icons.more_horiz,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                        child: Text("I am having a great day!")
                    ),
                    Container(
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Image.network(
                              friendList[index]['image'],
                              fit: BoxFit.cover,
                          )
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up,
                          color: Colors.blue,
                        ),
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                        Text("${friendList[index]['like']}"),
                        Spacer(),
                        Text("${friendList[index]['comment']} Comments"),
                        Text("  "),
                        Text("${friendList[index]['share']} Shares"),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FlatButton.icon(
                              onPressed: () {
                                friendList[index]['like'] = int.parse(friendList[index]['like'].toString()) + 1;
                                setState(() { });
                              },
                              icon: Icon(Icons.thumb_up),
                              label: Text("Like")
                          ),
                        ),
                        Expanded(
                          child: FlatButton.icon(
                              onPressed: (){},
                              icon: Icon(Icons.comment),
                              label: Text("Comment")
                          ),
                        ),
                        Expanded(
                          child: FlatButton.icon(
                              onPressed: (){},
                              icon: Icon(Icons.share),
                              label: Text("Share")
                          ),
                        ),
                      ],
                    )
                  ],
                )
              );
            }
        ),
      ),
    );
  }
}
