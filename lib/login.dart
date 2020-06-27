import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterappdemo2/GlobalInfo.dart';
import 'package:flutterappdemo2/friend_list_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var schoolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login"),
              TextField(
                controller: emailController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              TextField(
                controller: nameController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
              TextField(
                controller: schoolController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'School',
                ),
              ),
              RaisedButton(
                child: Text("Login"),
                onPressed: () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text, password: passwordController.text)
                      .then((value) {
                        print("Successfully sign in");
                        print(value.user.uid);
                        
                        FirebaseDatabase.instance.reference().child("users/" + value.user.uid).once()
                            .then((ds) {
                              print(ds.key);
                              print(ds.value);
                              GlobalInfo.userInfo = ds.value;

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FriendListPage()),
                              );

                            }).catchError((e) {
                              print("Failed to get the user information");
                            });


                      }).catchError((error) {
                        print("Failed to sign in");
                        print(error);
                      });
                },
              ),
              RaisedButton(
                child: Text("Signup"),
                onPressed: () {
                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text, password: passwordController.text)
                      .then((value) {
                        print("Successfully signed up. ");
                        var uid = value.user.uid;
                        FirebaseDatabase.instance.reference().child('users/' + uid).set(
                          {
                            'uid' : uid,
                            'email' : emailController.text.toString(),
                            'name' : nameController.text.toString(),
                            'school' : schoolController.text.toString(),
                          }
                        ).then((value) {
                          print("Successfully signed up the user with details.");
                        }).catchError((error) {
                          print("Failed to put the details.");
                          print(error);
                        });
                      }).catchError((error){
                        print("Failed to sign up");
                        print(error);
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
