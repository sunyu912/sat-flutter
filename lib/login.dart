import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

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
              RaisedButton(
                child: Text("Login"),
                onPressed: () {
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text, password: passwordController.text)
                      .then((value) {
                        print("Successfully sign in");
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
                        print(value);
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
