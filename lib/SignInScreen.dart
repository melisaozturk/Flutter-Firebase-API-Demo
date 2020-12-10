import 'package:flutter/material.dart';
import 'SignUpScreen.dart';

void main() {
  runApp(SignIn());
}

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SignIn"),
          backgroundColor: Colors.pink,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'UserName',
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),

              SizedBox(height: 30,),

              RaisedButton(
                onPressed: () {
                  // SignIn Button Action
                },
                child: Text("SignIn With Facebook"),
                color: Colors.blue,
              ),
              RaisedButton(
                onPressed: () async {
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (_) => SignUp()
                  )); // SignUp Button Action
                },
                child: Text("SignUp With Email"),
                color: Colors.pink,
              )
            ],
          ),
        ));
  }
}
