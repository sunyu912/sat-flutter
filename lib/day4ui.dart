import 'package:flutter/material.dart';

class Day4Page extends StatefulWidget {
  @override
  _Day4PageState createState() => _Day4PageState();
}

class _Day4PageState extends State<Day4Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 10,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        Icons.info,
                        size: 48,
                        color: Colors.pink,
                      ),
                    ),
                    Text("taylorswift"),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        Icons.favorite,
                        size: 24,
                        color: Colors.pink,
                      ),
                    ),
                    Text("follow"),
                  ],
                ),
              ),
              Expanded(
                flex: 75,
                child: Image.network(
                    "https://thumbor.forbes.com/thumbor/fit-in/416x416/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5cfea7bb4c687b0008593c0a%2F0x0.jpg%3Fbackground%3D000000%26cropX1%3D1554%26cropX2%3D2474%26cropY1%3D240%26cropY2%3D1159",
                    fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 15,
                child: Column(
                  children: [
                    Expanded(
                        flex: 45,
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              size: 36,
                              color: Colors.grey,
                            ),
                            Icon(
                              Icons.message,
                              size: 36,
                              color: Colors.grey,
                            ),
                            Icon(
                              Icons.share,
                              size: 36,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.tag_faces,
                                  size: 36,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                    Expanded(
                      flex: 55,
                      child: Text("The best soccer star in the world. Please like and share if you are a fan."),
                    )
                  ],
                ),
              )
            ],
      )),
    );
  }
}
