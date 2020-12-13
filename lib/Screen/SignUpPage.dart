import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_demo/PageUtil.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email;
  String _password;

  Future<void> _createUser() async {
    try {
      UserCredential _ = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      print("Sign up succesful");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoTextField(
                  placeholder: 'Email',
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
                CupertinoButton(
                  onPressed: _createUser,
                  child: Text("SignUp"),
                  color: Colors.redAccent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
