import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_firebase_demo/PageUtil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MyTopBar(
      text: "HomePage",
      uniqueHeroTag: 'tab1',
      child: Container(
        child: Center(
            child: RaisedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            await FacebookAuth.instance.logOut();
          },
          child: Text('Logout'),
        )),
      ),
    );
  }
}
