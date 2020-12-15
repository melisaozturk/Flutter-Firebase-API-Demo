import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_firebase_demo/PageUtil.dart';
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

  HomePage({Key key, @required this.listViewModel}) : super(key: key);


 /*
  final ListViewModel viewModel;


  HomePage(viewModel):
        this.viewModel = viewModel
  ;
*/
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
/* @override
  void initState() {
    super.initState();
    //set our varible state to be that of the parent screen
    //isMeeters is a local var to Settings and is changeable.
    //isM is a static and can't be changed. isM was passed in
    //from our home screen. We need a changeable var or the
    //checkboxes won't update correctly. Thats why we need
    //isMeeters (lol bad spelling). When the settings screen
    //first loads we use initState to take the value of
    //isM(from our home screen) and copy it into isMeeters
    //as it's initial value before it is built and shown
    //to the user for the first time.
    viewModel = widget.viewModel;
  }
 var viewModel;*/

  Future loadData() async {
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
