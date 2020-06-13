import 'package:flutter/material.dart';

class GroupChatPage extends StatefulWidget {
  @override
  _GroupChatPageState createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Text("Message"),
                        ],
                      ),
                    );
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Type your message here',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
