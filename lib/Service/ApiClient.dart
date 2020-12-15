import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/Photos.dart';
import '../Service/IApiClient.dart';

class ApiClient implements IApiClient {
  final _baseUrl = 'https://api.nasa.gov';
  http.Client _client = http.Client();

  set client(http.Client value) => _client = value;

  static final ApiClient _internal = ApiClient.internal();
  factory ApiClient() => _internal;
  ApiClient.internal();

  Future<List<Photos>> getPhotos() async {
    var response = await _client.get('$_baseUrl/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=r85lmJmv5IJHyXatxt9big3KnbKA4lv7oN3P57vz');

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<dynamic> filmsData = data['results'];
      List<Photos> photos = filmsData.map((f) => Photos.fromMap(f)).toList();

      return photos;
    } else {
      throw Exception('Failed to get data');
    }
  }

}


