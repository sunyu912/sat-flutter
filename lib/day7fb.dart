import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdemo2/day6listviewdemo.dart';

class MyFirebasePage extends StatefulWidget {
  @override
  _MyFirebasePageState createState() => _MyFirebasePageState();
}

class _MyFirebasePageState extends State<MyFirebasePage> {

  var nameEditingController = TextEditingController();
  var schoolEditingControoler = TextEditingController();
  var gradeLevelEditingController = TextEditingController();
  var gpaEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 100, left: 10, right: 10),
        child: Column(
          children: [
            TextField(
              controller: nameEditingController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: schoolEditingControoler,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'School',
              ),
            ),
            TextField(
              controller: gradeLevelEditingController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Grade Level',
              ),
            ),
            TextField(
              controller: gpaEditingController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'GPA',
              ),
            ),
            RaisedButton(
              child: Text("Add Student"),
              onPressed: () {
                print("ADD!");
                print(nameEditingController.text.toString());
                print(schoolEditingControoler.text.toString());
                print(gradeLevelEditingController.text.toString());
                print(gpaEditingController.text.toString());
                
                var stuId = 'stu' + new DateTime.now().millisecondsSinceEpoch.toString();

                FirebaseDatabase.instance.reference().child("students/" + stuId).set(
                  {
                    "name" : nameEditingController.text.toString(),
                    "school" : schoolEditingControoler.text.toString(),
                    "gradeLevel" : gradeLevelEditingController.text.toString(),
                    "gpa" : gpaEditingController.text.toString()
                  }
                ).then((res){
                  print("The student has been added successfully!");
                }).catchError((e) {
                  print("Failed to add the student.");
                });

              },
            ),
            RaisedButton(
              child: Text("Student List"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FriendListView()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
