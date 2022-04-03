import 'package:json_annotation/json_annotation.dart';
import 'package:weather_api/src/models/consolidated_weather.dart';

part 'weather.g.dart';

@JsonSerializable()

/// Main class call [Weather]
class Weather {
  /// Constructor of the [Weather] class
  Weather({
    required this.consolidatedWeather,
    required this.time,
    required this.title,
    required this.woeid,
  });

  /// Function to parse from json to [Weather] class
  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  /// List of [ConsolidatedWeather] class
  List<ConsolidatedWeather> consolidatedWeather;

  /// Current time of this weather
  final DateTime time;

  /// Title of the current location
  final String title;

  /// Identifier of the current location
  final int woeid;
}
