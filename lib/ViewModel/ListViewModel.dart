import 'dart:async';
import 'package:flutter_firebase_demo/Service/ApiClient.dart';
import 'package:meta/meta.dart';
import '../Model/Photos.dart';
import '../Service/IApiClient.dart';
import 'package:scoped_model/scoped_model.dart';


class ListViewModel extends Model {
  Future<List<Photos>> _photos;
  Future<List<Photos>> get photos => _photos;
  set photos(Future<List<Photos>> value) {
    _photos = value;
    notifyListeners();
  }

  final IApiClient apiSvc;

  ListViewModel({@required this.apiSvc});

  Future<bool> setPhotos() async {
    photos = apiSvc?.getPhotos();
    return photos != null;
  }
}
