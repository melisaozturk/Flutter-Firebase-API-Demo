import 'dart:async';
import '../Model/Photos.dart';


abstract class IApiClient {
  Future<List<Photos>> getPhotos();
}
