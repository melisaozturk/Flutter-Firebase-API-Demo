import 'package:flutter/material.dart';
import 'package:flutter_firebase_demo/PageUtil.dart';
import 'SignUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

String prettyPrint(Map json) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Map<String, dynamic> _userData;
  AccessToken _accessToken;

  /// print the access token data in the console
  void _printCredentials() {
    print(
      prettyPrint(_accessToken.toJson()),
    );
  }

  Future<void> _login() async {
    try {
      // TODO show a circular progress indicator
      _accessToken = await FacebookAuth.instance
          .login(); // by the fault we request the email and the public profile

      // loginBehavior is only supported for Android devices, for ios it will be ignored
      /* _accessToken = await FacebookAuth.instance.login(
         permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
         loginBehavior:
             LoginBehavior.DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
       );*/
      _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _userData = userData;

      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(_accessToken.token);

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on FacebookAuthException catch (e) {
      // if the facebook login fails
      print(e.message); // print the error message in console
      // check the error type
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
    } catch (e, s) {
      // print in the logs the unknown errors
      print(e);
      print(s);
    } finally {
      // TODO update the view
    }
  }

  Future<void> _logOut() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  String _email;
  String _password;

  Future<void> _signIn() async {
    try {
      UserCredential _ = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
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
        print('User null!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyTopBar(
        text: "Sign In",
        uniqueHeroTag: "signin",
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoTextField(
                    placeholder: "Email",
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                  CupertinoTextField(
                    placeholder: 'Password',
                    obscureText: true,
                    onChanged: (value) {
                      _password = value;
                    },
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  /// Sign in with email
                  CupertinoButton(
                    onPressed: _signIn,
                    child: Text("Sign In"),
                    color: Colors.lightGreen,
                  ),

                  /// if not sign up
                  CupertinoButton(
                    onPressed: () async {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => SignUp()));
                    },
                    child: Text("SignUp With Email"),
                    color: Colors.redAccent,
                  ),

                  /// Sign in with Facebook
                  CupertinoButton(
                      color: Colors.blue,
                      child: Text("Sign in with Facebook"),
                      onPressed: _userData != null ? _logOut : _login)
                ],
              ),
            ),
          )),
        ));
  }
}
