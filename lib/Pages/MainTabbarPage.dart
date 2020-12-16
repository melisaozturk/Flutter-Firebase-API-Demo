import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_demo/PageUtil.dart';
import 'package:flutter_firebase_demo/Pages/HomePage.dart';
import 'package:flutter_firebase_demo/ViewModel/ListViewModel.dart';
import '../ViewModel/ListViewModel.dart';
import 'dart:async';

import 'package:flutter_firebase_demo/Pages/MainTabbarPage.dart';
import 'package:scoped_model/scoped_model.dart';

class MainTabbarPage extends StatefulWidget {

  final ListViewModel listViewModel;

  MainTabbarPage({@required this.listViewModel});

  @override
  _MainTabbarPageState createState() => _MainTabbarPageState();
}

class _MainTabbarPageState extends State<MainTabbarPage> {
  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listViewModel = widget.listViewModel;
  }
  var listViewModel;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Curiosity'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Opportunity'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Spirit'),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        if (index == 0) {
          return CupertinoTabView(
              navigatorKey: firstTabNavKey,
              builder: (BuildContext context) => HomePage(listViewModel: listViewModel, tabbarIndex: index)
          );
        } else if (index == 1) {
          return CupertinoTabView(
            navigatorKey: secondTabNavKey,
            builder: (BuildContext context) => HomePage(listViewModel: listViewModel, tabbarIndex: index),
          );
        } else {
          return CupertinoTabView(
            navigatorKey: thirdTabNavKey,
            builder: (BuildContext context) => HomePage(listViewModel: listViewModel, tabbarIndex: index),
          );
        }
      },
    );
  }
}

class SampleTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyTopBar(
      uniqueHeroTag: 'sample',
      child: Container(
        child: Center(
          child: Text('Logout'),
        ),
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyTopBar(
      uniqueHeroTag: 'profile',
      child: Container(
        child: Center(),
      ),
    );
  }
}