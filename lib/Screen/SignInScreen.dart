import 'package:flutter/material.dart';
import 'SignUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
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

              SizedBox(
                height: 30,
              ),

              /// Sign in
              RaisedButton(
                onPressed: () async {
                  try {
                    UserCredential _ =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            // TODO: set textfield data
                            email: "melisa.ozturk@example.com",
                            password: "SuperSecretPassword!");
                      print("Sign in succesful");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                  }

                  FirebaseAuth.instance.authStateChanges().listen((User user) {
                    if (user == null) {
                      print('An error occured!');
                    } else {
                      print('User is signed in!');
                    }
                  });
                },
                child: Text("Sign In"),
                color: Colors.lightGreen,
              ),

              /// if not sign up got to Sign up
              RaisedButton(
                onPressed: () async {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SignUp()));
                },
                child: Text("SignUp With Email"),
                color: Colors.pink,
              ),

              /// Sign in with Facebook
              RaisedButton(
                onPressed: () async {
                  // TODO Facebook sign in
                },
                child: Text("Sign In With Facebook"),
                color: Colors.blue,
              )
            ],
          ),
        ));
  }
}
