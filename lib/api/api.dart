// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:sprint2/api/http_handler.dart';
import 'package:sprint2/models/data_models.dart';

class SprintApi {
  HttpHandler httpHandler = HttpHandler();

  Future<List<News>> getNews() async {
    String _baseUrl = 'newsapi.org';
    String _headlinePath = 'v2/top-headlines';
    String _apiKey = '51c28aa5fa0b49518aea09713afc8579';

    final _url = Uri.http(
      _baseUrl,
      _headlinePath,
      {
        'apiKey': _apiKey,
        'country': "in",
      },
    );

    final resp = await httpHandler.getData(_url);

    if (resp['status'] == 'SUCCESS') {
      return (resp['data']['articles'] as List)
          .map((e) => News.fromJson(e))
          .toList();
    } else {
      throw Exception(resp['data']);
    }
  }

  Future<Weather> getWeather() async {
    String _baseUrl = 'api.weatherapi.com';
    String _currentWeatherPath = 'v1/current.json';
    String _apiKey = '47cfdac11ee241dd97572829222207';

    final _url = Uri.http(
      _baseUrl,
      _currentWeatherPath,
      {
        'key': _apiKey,
        'q': "Noida",
        'aqi': "yes",
      },
    );

    final resp = await httpHandler.getData(_url);

    if (resp['status'] == 'SUCCESS') {
      return Weather.fromJson(resp['data']);
    } else {
      throw Exception(resp['data']);
    }
  }
}
