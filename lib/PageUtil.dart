import 'package:flutter/material.dart';

class PageUtil {
  static final PageUtil _instance = PageUtil._internal();

  factory PageUtil() {
    return _instance;
  }

  PageUtil._internal();

}
