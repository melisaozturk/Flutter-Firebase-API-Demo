import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_firebase_demo/PageUtil.dart';
import 'package:flutter_firebase_demo/Service/ApiClient.dart';
import 'package:flutter_firebase_demo/Widgets/PhotosPanel.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../Model/Photos.dart';
import '../ViewModel/ListViewModel.dart';
import '../Widgets/PhotosListItem.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatefulWidget {
  final ListViewModel listViewModel;
  final int tabbarIndex;

  HomePage({Key key, @required this.listViewModel, @required this.tabbarIndex}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future loadData() async {
    switch (widget.tabbarIndex) {
      case 0:
        ApiClient().serviceSource = ServiceSource.curiosity;
        break;
      case 1:
        ApiClient().serviceSource = ServiceSource.spirit;
        break;
      case 2:
        ApiClient().serviceSource = ServiceSource.opportunity;
        break;
    }

    await widget.listViewModel.setPhotos();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MyTopBar(
        text: "HomePage",
        uniqueHeroTag: 'tab1',
        child: ScopedModel<ListViewModel>(
          model: widget.listViewModel,
            child: Center(
               child: Column(
                 children: <Widget>[
                   PhotosPanel()
                 ],
               ),
            ),
    )
    );
  }
}






/*
ListView.builder(
            itemCount: photoArray.length,
            itemBuilder: (BuildContext context, int position) {
              print("photoArray.length ${photoArray.length}");
              print("position ${position}");
              return getRow(position);
            })
 */

/*
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
 */
