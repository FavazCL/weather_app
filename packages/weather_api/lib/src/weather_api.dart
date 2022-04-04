import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_api/src/models/location.dart';
import 'package:weather_api/src/models/weather.dart';

/// The interface for an [WeatherApi]
class WeatherApi {
  /// Constructor of [WeatherApi] class
  WeatherApi({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'www.metaweather.com';
  final http.Client _httpClient;

  /// GET a [Location] given a City
  Future<Location> locationSearch(String query) async {
    final locationRequest = Uri.https(
      _baseUrl,
      '/api/location/search',
      <String, String>{'query': query},
    );
    
    final locationResponse = await _httpClient.get(locationRequest);

    if (locationResponse.statusCode != 200) {
      throw LocationRequestFailure();
    }

    final locationJson = jsonDecode(
      locationResponse.body,
    ) as List;

    if (locationJson.isEmpty) {
      throw LocationRequestFailure();
    }

    return Location.fromJson(locationJson.first as Map<String, dynamic>);
  }

  /// GET [Weather] given a [locationId].
  Future<Weather> getWeather(int locationId) async {
    final weatherRequest = Uri.https(_baseUrl, '/api/location/$locationId');
    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (bodyJson.isEmpty) {
      throw WeatherRequestFailure();
    }

    return Weather.fromJson(bodyJson);
  }
}

/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}
