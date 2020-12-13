import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class PageUtil {
  static final PageUtil _instance = PageUtil._internal();

  factory PageUtil() {
    return _instance;
  }

  PageUtil._internal();

  bool isIOS;

}

class MyTopBar extends StatelessWidget {

  final String text;
  final TextStyle style;
  final String uniqueHeroTag;
  final Widget child;

  MyTopBar({
    this.text,
    this.style,
    this.uniqueHeroTag,
    this.child,
  });

  void initState() {
    Platform.isIOS ? PageUtil().isIOS = true : PageUtil().isIOS = false;
  }

  @override
  Widget build(BuildContext context) {
    initState();
    if (!PageUtil().isIOS) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            text,
            style: style,
          ),
        ),
        body: child,
      );
    } else {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          heroTag: uniqueHeroTag,
          transitionBetweenRoutes: false,
          middle: Text(
            text,
            style: style,
          ),
        ),
        child: child,
      );
    }
  }
}