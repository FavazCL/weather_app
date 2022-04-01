import 'package:weather_api/src/models/weather.dart';

/// {@template weather_api}
/// The interface and models for an API providing access to weather.
/// {@endtemplate}
abstract class WeatherApi {
  /// {@macro weather_api}
  const WeatherApi();

  /// Provides a [Stream] of all todos.
  Stream<List<Weather>> getWeather({required int woeid});
}

/// Error thrown when a [Weather] with a given id is not found.
class TodoNotFoundException implements Exception {}
