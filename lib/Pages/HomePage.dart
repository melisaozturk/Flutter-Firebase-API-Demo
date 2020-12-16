import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_firebase_demo/PageUtil.dart';
import 'package:flutter_firebase_demo/Service/ApiClient.dart';
import 'package:flutter_firebase_demo/WidgetsPanel/PhotosPanel.dart';
import 'package:scoped_model/scoped_model.dart';
import '../ViewModel/ListViewModel.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  final ListViewModel listViewModel;
  final int tabbarIndex;

  HomePage({Key key, @required this.listViewModel, @required this.tabbarIndex})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get floatingActionButton => null;

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
          child: Column(
            children: [
              Platform.isIOS ? SizedBox(height: 100,) : SizedBox(height: 0,),
              FloatingActionButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await FacebookAuth.instance.logOut();
                },
                child: Text("SignOut"),
                backgroundColor: Colors.green,
              ),
              Platform.isIOS ? SizedBox(height: 0,) : SizedBox(height: 20,),
              PhotosPanel(),
            ],
        ),
      ),
    );
  }
}