import 'package:flutter/material.dart';
import 'dart:math';

class Day5DemoPage extends StatefulWidget {
  @override
  _Day5DemoPageState createState() => _Day5DemoPageState();
}

class _Day5DemoPageState extends State<Day5DemoPage> {

  var num = 100; // State
  var imageUrl = "https://lh3.googleusercontent.com/proxy/bzoJI3RBgao_5lWyj0kyylRPXL6kD1xebllIIHa_UFGvOh6WMApaAuj4O3mCCsbsKkob29a-Pv5f4TD20KuKz6BjN3zIWLI";
  var imageList = [
    "https://www.jeffskipperconsulting.com/wp-content/uploads/2017/05/47036176-fun-pictures-1.jpg",
    "https://cdn.pixabay.com/photo/2015/08/14/19/42/frog-888798_960_720.jpg",
    "https://img.clipartlook.com/clip-art-fun-clip-art-fun-640_379.jpg",
    "https://i.ytimg.com/vi/CAb_bCtKuXg/maxresdefault.jpg",
    "https://i.ya-webdesign.com/images/kids-fun-png-1.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Text(
                "Score: $num",
                style: TextStyle(fontSize: 60)
              ),
              Image.network(imageUrl),
              RaisedButton(
                child: Text("Get My Score"),
                onPressed: () {
                  print("Button cilcked!! " + num.toString());
                  var random = Random();

                  imageUrl = imageList[random.nextInt(5)];
                  num = random.nextInt(100);

                  setState(() {});
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
