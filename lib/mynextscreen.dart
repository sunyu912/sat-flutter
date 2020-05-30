import 'package:flutter/material.dart';

class MyNextPage extends StatefulWidget {
  MyNextPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyNextPageState createState() => _MyNextPageState();
}

class _MyNextPageState extends State<MyNextPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    print("The counter has been increased by 1. " + _counter.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.yellow,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Container(
            //    child : ....
            // )

            Container(
              height: 100,
              width: 250,
              child: Image.network(
                  "https://codingmindsacademy.com/img/my/logo1.png"),
            ),

            Text(
              "Flutter Mobile Development UI",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
            ),

            Container(
              height: 30,
              child: Text("This is a Text"),
            ),

            // Row(
            //   children: [  ]
            // )

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Please login: "),
                Container(
                  child: RaisedButton(
                    child: Text(
                      "New Login",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      print("Button is clicked!");
                    },
                  ),
                ),
                FlatButton(
                  child: Text("Signup"),
                  onPressed: () {
                    print("Flat is clicked!");
                  },
                ),
              ],
            ),

            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
            )
          ],
        ),
      ),
    );
  }
}
