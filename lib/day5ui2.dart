import 'package:flutter/material.dart';

class ListViewDemoPage extends StatefulWidget {
  @override
  _ListViewDemoPageState createState() => _ListViewDemoPageState();
}

class _ListViewDemoPageState extends State<ListViewDemoPage> {

//  var messageList = [
//    "How are you?",
//    "What's pbug level?",
//    "What's your discard id?",
//    "Do you know Flutter?",
//    "Do you still play Minecraft?",
//    "How are you?",
//    "What's pbug level?",
//    "What's your discard id?",
//    "Do you know Flutter?",
//    "Do you still play Minecraft?",
//  ];
//
//  var iconList = [
//    Icons.favorite,
//    Icons.share,
//    Icons.info,
//    Icons.message,
//    Icons.timer,
//    Icons.favorite,
//    Icons.share,
//    Icons.info,
//    Icons.message,
//    Icons.timer
//  ];
//
//  var colorList = [
//    Colors.red,
//    Colors.green,
//    Colors.yellow,
//    Colors.orange,
//    Colors.blue,
//    Colors.red,
//    Colors.green,
//    Colors.yellow,
//    Colors.orange,
//    Colors.blue
//  ];

  var messageTemplateList = [
    {
      "message" : "How are you?",
      "icon" : Icons.favorite,
      "color" : Colors.red
    },
    {
      "message" : "Minecraft Good?",
      "icon" : Icons.computer,
      "color" : Colors.yellow
    },
    {
      "message" : "Are you a coder?",
      "icon" : Icons.book,
      "color" : Colors.orange
    },
    {
      "message" : "How do you write apps?",
      "icon" : Icons.info,
      "color" : Colors.blue
    },
    {
      "message" : "How many exams do you have?",
      "icon" : Icons.message,
      "color" : Colors.purple
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: messageTemplateList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: new BoxDecoration (
                            color: messageTemplateList[index]['color']
                        ),
                        child: ListTile(
                          onTap: (){
                            print("Clicked on " + index.toString());
                            print(messageTemplateList[index]['message']);
                          },
                          title: Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                            color: messageTemplateList[index]['color'],
                            child: Row(
                              children: <Widget>[
                                Icon(messageTemplateList[index]['icon']),
                                Text(messageTemplateList[index]['message']),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
