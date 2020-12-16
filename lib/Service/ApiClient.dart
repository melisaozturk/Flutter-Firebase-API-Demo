import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/Photos.dart';
import '../Service/IApiClient.dart';

enum ServiceSource {
  curiosity,
  spirit,
  opportunity
}

class ApiClient implements IApiClient {
  final _baseUrl = 'https://api.nasa.gov';
  http.Client _client = http.Client();

  set client(http.Client value) => _client = value;

  static final ApiClient _internal = ApiClient.internal();
  factory ApiClient() => _internal;
  ApiClient.internal();

  ServiceSource serviceSource;

  Future<List<Photos>> getPhotos() async {
    String url;
    switch (serviceSource) {
      case ServiceSource.curiosity:
        url = '$_baseUrl/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=EJuEQWttb31Pn9z1x14eeOq9GXwpDQN2q7kXuuW4';
        break;
      case ServiceSource.spirit:
        url = '$_baseUrl/mars-photos/api/v1/rovers/spirit/photos?sol=1000&api_key=EJuEQWttb31Pn9z1x14eeOq9GXwpDQN2q7kXuuW4';
        break;
      case ServiceSource.opportunity:
        url = '$_baseUrl/mars-photos/api/v1/rovers/opportunity/photos?sol=1000&api_key=EJuEQWttb31Pn9z1x14eeOq9GXwpDQN2q7kXuuW4';
        break;
    }

    var response = await _client.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<dynamic> photosData = data['photos'];
      List<Photos> photos = photosData.map((p) => Photos.fromMap(p)).toList();

      return photos;
    } else {
      throw Exception('Failed to get data');
    }
  }

}


