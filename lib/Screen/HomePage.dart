import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_firebase_demo/PageUtil.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../Model/Photo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Photo> photoArray = new List<Photo>();

  void getPhotos() async {
    Response res = await get(
        "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=r85lmJmv5IJHyXatxt9big3KnbKA4lv7oN3P57vz");

    var data = await jsonDecode(res.body);

    setState(() {
      for (var i = 0; i < data.lenght; i++) {
        Photo photo = new Photo();
        photo.rover.name = data[i]['rover']['name'];
        photo.img_src = data[i]['img_src'];

        photoArray.add(photo);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return MyTopBar(
      text: "HomePage",
      uniqueHeroTag: 'tab1',
      child: Center(
       // children: [
         child: RaisedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await FacebookAuth.instance.logOut();
            },
            child: Text("Logout"),
          )
       // ],
      ),
    );
  }
}
